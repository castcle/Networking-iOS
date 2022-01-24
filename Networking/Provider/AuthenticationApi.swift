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
    case checkEmailExists(AuthenRequest)
    case suggestCastcleId(AuthenRequest)
    case checkCastcleIdExists(AuthenRequest)
    case register(AuthenRequest)
    case verificationEmail
    case requestLinkVerify
    case refreshToken
    case verificationPassword(AuthenRequest)
    case changePasswordSubmit(AuthenRequest)
    case requestOtp(AuthenRequest)
    case verificationOtp(AuthenRequest)
    case loginWithSocial(AuthenRequest)
}

extension AuthenticationApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .guestLogin:
            return "/authentications/guestLogin"
        case .login:
            return "/authentications/login"
        case .checkEmailExists:
            return "/authentications/checkEmailExists"
        case .suggestCastcleId:
            return "/authentications/suggestCastcleId"
        case .checkCastcleIdExists:
            return "/authentications/checkCastcleIdExists"
        case .register:
            return "/authentications/register"
        case .verificationEmail:
            return "/authentications/verificationEmail"
        case .requestLinkVerify:
            return "/authentications/requestLinkVerify"
        case .refreshToken:
            return "/authentications/refreshToken"
        case .verificationPassword:
            return "/authentications/verificationPassword"
        case .changePasswordSubmit:
            return "/authentications/changePasswordSubmit"
        case .requestOtp:
            return "/authentications/requestOTP"
        case .verificationOtp:
            return "/authentications/verificationOTP"
        case .loginWithSocial:
            return "/authentications/login-with-social"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "{\"message\": \"success message\"}".dataEncoded
    }
    
    var task: Task {
        switch self {
        case .guestLogin(let uuid):
            return .requestParameters(parameters: [AuthenticationApiKey.uuid.rawValue: uuid], encoding: JSONEncoding.default)
        case .login(let loginRequest):
            return .requestParameters(parameters: loginRequest.paramLogin, encoding: JSONEncoding.default)
        case .checkEmailExists(let authenRequest):
            return .requestParameters(parameters: authenRequest.payload.paramCheckEmailExists, encoding: JSONEncoding.default)
        case .suggestCastcleId(let authenRequest):
            return .requestParameters(parameters: authenRequest.payload.paramSuggestCastcleId, encoding: JSONEncoding.default)
        case .checkCastcleIdExists(let authenRequest):
            return .requestParameters(parameters: authenRequest.payload.paramCheckCastcleIdExists, encoding: JSONEncoding.default)
        case .register(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramRegister, encoding: JSONEncoding.default)
        case .verificationPassword(let authenRequest):
            return .requestParameters(parameters: authenRequest.payload.paramVerificationPassword, encoding: JSONEncoding.default)
        case .changePasswordSubmit(let authenRequest):
            return .requestParameters(parameters: authenRequest.payload.paramChangePasswordSubmit, encoding: JSONEncoding.default)
        case .requestOtp(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramRequestOtp, encoding: JSONEncoding.default)
        case .verificationOtp(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramVerifyOtp, encoding: JSONEncoding.default)
        case .loginWithSocial(let authenRequest):
            return .requestParameters(parameters: authenRequest.paramLoginWithSocial, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .refreshToken:
            return ApiHelper.headerRefreshToken
        default:
            return ApiHelper.header
        }
    }
}
