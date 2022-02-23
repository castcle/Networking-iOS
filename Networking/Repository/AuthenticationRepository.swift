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
    func guestLogin(uuid: String, _ completion: @escaping (Bool) -> ())
    func login(loginRequest: LoginRequest, _ completion: @escaping complate)
    func checkEmailExists(authenRequest: AuthenRequest, _ completion: @escaping (Bool, Bool) -> ())
    func suggestCastcleId(authenRequest: AuthenRequest, _ completion: @escaping complate)
    func checkCastcleIdExists(authenRequest: AuthenRequest, _ completion: @escaping complate)
    func register(authenRequest: AuthenRequest, _ completion: @escaping complate)
    func verificationEmail(_ completion: @escaping (Bool) -> ())
    func requestLinkVerify(_ completion: @escaping complate)
    func refreshToken(_ completion: @escaping (Bool, Bool) -> ())
    func verifyPassword(authenRequest: AuthenRequest, _ completion: @escaping complate)
    func changePasswordSubmit(authenRequest: AuthenRequest, _ completion: @escaping complate)
    func requestOtp(authenRequest: AuthenRequest, _ completion: @escaping complate)
    func verificationOtp(authenRequest: AuthenRequest, _ completion: @escaping complate)
    func loginWithSocial(authenRequest: AuthenRequest, _ completion: @escaping complate)
}

public enum AuthenticationApiKey: String {
    case uuid = "deviceUUID"
    case accessToken
    case refreshToken
    case exist
    case suggestCastcleId
    case payload
    case refCode
    case profile
    case pages
}

public final class AuthenticationRepositoryImpl: AuthenticationRepository {
    private let authenticationProvider = MoyaProvider<AuthenticationApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()
    private let realm = try! Realm()
    
    public init() {
        // MARK: - Init
    }
    
    public func guestLogin(uuid: String, _ completion: @escaping (Bool) -> ()) {
        self.authenticationProvider.request(.guestLogin(uuid)) { result in
            switch result {
            case .success(let response):
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    if response.statusCode < 300 {
                        let accessToken = json[AuthenticationApiKey.accessToken.rawValue].stringValue
                        let refreshToken = json[AuthenticationApiKey.refreshToken.rawValue].stringValue
                        UserManager.shared.setUserRole(userRole: .guest)
                        UserManager.shared.setAccessToken(token: accessToken)
                        UserManager.shared.setRefreshToken(token: refreshToken)
                        completion(true)
                    } else {
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
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
    
    public func login(loginRequest: LoginRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.login(loginRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func checkEmailExists(authenRequest: AuthenRequest, _ completion: @escaping (Bool, Bool) -> ()) {
        self.authenticationProvider.request(.checkEmailExists(authenRequest)) { result in
            switch result {
            case .success(let response):
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    if response.statusCode < 300 {
                        let payload = JSON(json[AuthenticationApiKey.payload.rawValue].dictionaryValue)
                        let exist = payload[AuthenticationApiKey.exist.rawValue].boolValue
                        completion(true, exist)
                    } else {
                        ApiHelper.displayError(error: "\(json[ResponseErrorKey.code.rawValue].stringValue) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
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
    
    public func suggestCastcleId(authenRequest: AuthenRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.suggestCastcleId(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func checkCastcleIdExists(authenRequest: AuthenRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.checkCastcleIdExists(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func register(authenRequest: AuthenRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.register(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func verificationEmail(_ completion: @escaping (Bool) -> ()) {
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
                        ApiHelper.displayError(error: "\(json[ResponseErrorKey.code.rawValue].stringValue) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
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
    
    public func requestLinkVerify(_ completion: @escaping complate) {
        self.authenticationProvider.request(.requestLinkVerify) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func refreshToken(_ completion: @escaping (Bool, Bool) -> ()) {
        self.authenticationProvider.request(.refreshToken) { result in
            switch result {
            case .success(let response):
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    if response.statusCode < 300 {
                        let accessToken = json[AuthenticationApiKey.accessToken.rawValue].stringValue
                        let profile = JSON(json[AuthenticationApiKey.profile.rawValue].dictionaryValue)
                        let pages = json[AuthenticationApiKey.pages.rawValue].arrayValue
                        let userHelper = UserHelper()
                        userHelper.updateLocalProfile(user: User(json: profile))
                        let pageRealm = self.realm.objects(Page.self)
                        try! self.realm.write {
                            self.realm.delete(pageRealm)
                        }
                        
                        pages.forEach { page in
                            let pageInfo = PageInfo(json: page)
                            try! self.realm.write {
                                let pageTemp = Page()
                                pageTemp.id = pageInfo.id
                                pageTemp.castcleId = pageInfo.castcleId
                                pageTemp.displayName = pageInfo.displayName
                                pageTemp.avatar = pageInfo.images.avatar.thumbnail
                                pageTemp.cover = pageInfo.images.cover.fullHd
                                pageTemp.overview = pageInfo.overview
                                pageTemp.official = pageInfo.verified.official
                                self.realm.add(pageTemp, update: .modified)
                            }
                            
                        }
                        
                        UserManager.shared.setAccessToken(token: accessToken)
                        completion(true, false)
                    } else {
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshTokenExpired {
                            completion(false, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
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
    
    public func verifyPassword(authenRequest: AuthenRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.verificationPassword(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func changePasswordSubmit(authenRequest: AuthenRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.changePasswordSubmit(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func requestOtp(authenRequest: AuthenRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.requestOtp(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func verificationOtp(authenRequest: AuthenRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.verificationOtp(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func loginWithSocial(authenRequest: AuthenRequest, _ completion: @escaping complate) {
        self.authenticationProvider.request(.loginWithSocial(authenRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
}
