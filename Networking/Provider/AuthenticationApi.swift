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
//  AuthenticationApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 12/8/2564 BE.
//

import Core
import Moya

enum AuthenticationApi {
    case guestLogin(String)
    case login(LoginRequest)
    case checkEmail(AuthenRequest)
    case suggestCastcleId(AuthenRequest)
    case checkCastcleId(AuthenRequest)
    case register(AuthenRequest)
    case verificationEmail
    case requestLinkVerify
    case refreshToken
    case verificationPassword(AuthenRequest)
    case changePasswordSubmit(AuthenRequest)
    case requestOtp(AuthenRequest)
    case requestOtpWithEmail(AuthenRequest)
    case verificationOtp(AuthenRequest)
    case loginWithSocial(AuthenRequest)
    case connectWithSocial(AuthenRequest)
}

extension AuthenticationApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .guestLogin:
            return APIs.Authentication.guestLogin.path
        case .login:
            return APIs.Authentication.login.path
        case .checkEmail:
            return APIs.Authentication.checkEmail.path
        case .suggestCastcleId:
            return APIs.Authentication.suggestCastcleId.path
        case .checkCastcleId:
            return APIs.Authentication.checkCastcleId.path
        case .register:
            return APIs.Authentication.register.path
        case .verificationEmail:
            return APIs.Authentication.verificationEmail.path
        case .requestLinkVerify:
            return APIs.Authentication.requestLinkVerify.path
        case .refreshToken:
            return APIs.Authentication.refreshToken.path
        case .verificationPassword:
            return APIs.Authentication.verificationPassword.path
        case .changePasswordSubmit:
            return APIs.Authentication.changePasswordSubmit.path
        case .requestOtp:
            return APIs.Authentication.requestOtp.path
        case .requestOtpWithEmail:
            return APIs.Authentication.requestOtpWithEmail.path
        case .verificationOtp:
            return APIs.Authentication.verificationOtp.path
        case .loginWithSocial:
            return APIs.Authentication.loginWithSocial.path
        case .connectWithSocial:
            return APIs.Authentication.connectWithSocial.path
        }
    }

    var method: Moya.Method {
        return .post
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .guestLogin(let uuid):
            return .requestParameters(parameters: [JsonKey.deviceUuid.rawValue: uuid], encoding: JSONEncoding.default)
        case .login(let loginRequest):
            return .requestParameters(parameters: loginRequest.paramLogin, encoding: JSONEncoding.default)
        case .checkEmail(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramCheckEmail, encoding: JSONEncoding.default)
        case .suggestCastcleId(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramSuggestCastcleId, encoding: JSONEncoding.default)
        case .checkCastcleId(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramCheckCastcleId, encoding: JSONEncoding.default)
        case .register(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramRegister, encoding: JSONEncoding.default)
        case .verificationPassword(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramVerificationPassword, encoding: JSONEncoding.default)
        case .changePasswordSubmit(let authenRequest):
            return .requestParameters(parameters: authenRequest.payload.paramChangePasswordSubmit, encoding: JSONEncoding.default)
        case .requestOtp(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramRequestOtp, encoding: JSONEncoding.default)
        case .requestOtpWithEmail(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramRequestOtpWithEmail, encoding: JSONEncoding.default)
        case .verificationOtp(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramVerifyOtp, encoding: JSONEncoding.default)
        case .loginWithSocial(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramLoginWithSocial, encoding: JSONEncoding.default)
        case .connectWithSocial(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramLoginWithSocial, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .guestLogin, .login, .checkEmail, .checkCastcleId, .loginWithSocial, .requestOtpWithEmail:
            return ApiHelper.header()
        case .refreshToken:
            return ApiHelper.headerRefreshToken()
        default:
            return ApiHelper.header(version: "1.0")
        }
    }
}
