//  Copyright (c) 2021, Castcle and/or its affiliates. All rights reserved.
//  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
//
//  This code is free software; you can redistribute it and/or modify it
//  under the terms of the GNU General Public License version 3 only, as
//  published by the Free Software Foundation.
//
//  This code is distributed in the hope that it will be useful, but WITHOUT
//  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
//  FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
//  version 3 for more details (a copy is included in the LICENSE file that
//  accompanied this code).
//
//  You should have received a copy of the GNU General Public License version
//  3 along with this work; if not, write to the Free Software Foundation,
//  Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
//
//  Please contact Castcle, 22 Phet Kasem 47/2 Alley, Bang Khae, Bangkok,
//  Thailand 10160, or visit www.castcle.com if you need additional information
//  or have any questions.
//
//  AuthenticationRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 12/8/2564 BE.
//

import Core
import Moya
import SwiftyJSON
import Defaults
import RealmSwift

public protocol AuthenticationRepository {
    func guestLogin(uuid: String, _ completion: @escaping (Bool) -> Void)
    func login(loginRequest: LoginRequest, _ completion: @escaping ResponseHandle)
    func checkEmail(authenRequest: AuthenRequest, _ completion: @escaping (Bool, Bool) -> Void)
    func suggestCastcleId(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func checkCastcleId(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func register(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func verificationEmail(_ completion: @escaping (Bool) -> Void)
    func requestLinkVerify(_ completion: @escaping ResponseHandle)
    func refreshToken(_ completion: @escaping (Bool, Bool) -> Void)
    func verifyPassword(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func changePasswordSubmit(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func requestOtp(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func requestOtpWithEmail(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func verificationOtp(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func loginWithSocial(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
    func connectWithSocial(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle)
}

public final class AuthenticationRepositoryImpl: AuthenticationRepository {
    private let authenticationProvider = MoyaProvider<AuthenticationApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()

    public init() {
        // MARK: - Init
    }

    public func guestLogin(uuid: String, _ completion: @escaping (Bool) -> Void) {
        self.authenticationProvider.request(.guestLogin(uuid)) { result in
            switch result {
            case .success(let response):
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    if response.statusCode < 300 {
                        let accessToken = json[JsonKey.accessToken.rawValue].stringValue
                        let refreshToken = json[JsonKey.refreshToken.rawValue].stringValue
                        UserManager.shared.setUserRole(userRole: .guest)
                        UserManager.shared.setAccessToken(token: accessToken)
                        UserManager.shared.setRefreshToken(token: refreshToken)
                        completion(true)
                    } else {
                        let code = json[JsonKey.code.rawValue].stringValue
                        ApiHelper.displayError(code: "\(code)", error: "\(json[JsonKey.message.rawValue].stringValue)")
                        completion(false)
                    }
                } catch {
                    ApiHelper.displayError()
                    completion(false)
                }
            case .failure:
                ApiHelper.displayError()
                completion(false)
            }
        }
    }

    public func login(loginRequest: LoginRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.login(loginRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func checkEmail(authenRequest: AuthenRequest, _ completion: @escaping (Bool, Bool) -> Void) {
        self.authenticationProvider.request(.checkEmail(authenRequest)) { result in
            switch result {
            case .success(let response):
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    if response.statusCode < 300 {
                        let payload = JSON(json[JsonKey.payload.rawValue].dictionaryValue)
                        let exist = payload[JsonKey.exist.rawValue].boolValue
                        completion(true, exist)
                    } else {
                        ApiHelper.displayError(code: "\(json[JsonKey.code.rawValue].stringValue)", error: "\(json[JsonKey.message.rawValue].stringValue)")
                        completion(false, false)
                    }
                } catch {
                    ApiHelper.displayError()
                    completion(false, false)
                }
            case .failure:
                ApiHelper.displayError()
                completion(false, false)
            }
        }
    }

    public func suggestCastcleId(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.suggestCastcleId(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func checkCastcleId(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.checkCastcleId(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func register(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.register(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func verificationEmail(_ completion: @escaping (Bool) -> Void) {
        self.authenticationProvider.request(.requestLinkVerify) { result in
            switch result {
            case .success(let response):
                do {
                    if response.statusCode <= 204 {
                        completion(true)
                    }
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    if response.statusCode < 300 {
                        completion(true)
                    } else {
                        ApiHelper.displayError(code: "\(json[JsonKey.code.rawValue].stringValue)", error: "\(json[JsonKey.message.rawValue].stringValue)")
                        completion(false)
                    }
                } catch {
                    ApiHelper.displayError()
                    completion(false)
                }
            case .failure:
                ApiHelper.displayError()
                completion(false)
            }
        }
    }

    public func requestLinkVerify(_ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.requestLinkVerify) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func refreshToken(_ completion: @escaping (Bool, Bool) -> Void) {
        self.authenticationProvider.request(.refreshToken) { result in
            switch result {
            case .success(let response):
                do {
                    let realm = try Realm()
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    if response.statusCode < 300 {
                        let accessToken = json[JsonKey.accessToken.rawValue].stringValue
                        let refreshToken = json[JsonKey.refreshToken.rawValue].stringValue
                        let profile = JSON(json[JsonKey.profile.rawValue].dictionaryValue)
                        let pages = json[JsonKey.pages.rawValue].arrayValue
                        UserHelper.shared.updateLocalProfile(user: UserInfo(json: profile))
                        let pageRealm = realm.objects(Page.self)
                        try realm.write {
                            realm.delete(pageRealm)
                        }
                        UserHelper.shared.updatePage(pages: pages)
                        UserManager.shared.setAccessToken(token: accessToken)
                        if !refreshToken.isEmpty {
                            UserManager.shared.setRefreshToken(token: refreshToken)
                        }
                        completion(true, false)
                    } else {
                        let code = json[JsonKey.code.rawValue].stringValue
                        if code == errorRefreshTokenExpired {
                            completion(false, true)
                        } else {
                            ApiHelper.displayError(code: "\(code)", error: "\(json[JsonKey.message.rawValue].stringValue)")
                            completion(false, false)
                        }
                    }
                } catch {
                    ApiHelper.displayError()
                    completion(false, false)
                }
            case .failure:
                ApiHelper.displayError()
                completion(false, false)
            }
        }
    }

    public func verifyPassword(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.verificationPassword(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func changePasswordSubmit(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.changePasswordSubmit(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func requestOtp(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.requestOtp(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func requestOtpWithEmail(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.requestOtpWithEmail(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func verificationOtp(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.verificationOtp(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func loginWithSocial(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.loginWithSocial(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(isSocialLogin: true, response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func connectWithSocial(authenRequest: AuthenRequest, _ completion: @escaping ResponseHandle) {
        self.authenticationProvider.request(.connectWithSocial(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }
}
