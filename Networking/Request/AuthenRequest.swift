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
//  AuthenRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 12/8/2564 BE.
//

public enum AuthenChannelKey: String {
    case mobile
    case email
}

public enum AuthenObjective: String {
    case forgotPassword = "forgot_password"
    case changePassword = "change_password"
    case verifyMobile = "verify_mobile"
    case none
}

public enum SocialProvider: String {
    case facebook
    case twitter
    case google
    case apple = "apple id"
    case none
}

public struct AuthenRequest {
    enum AuthenRequestKey: String {
        case objective
        case channel
        case payload
        case refCode
        case otp
        case provider
        case socialId
        case displayName
        case avatar
        case email
        case authToken
        case password
    }
    
    public var objective: AuthenObjective
    public var channel: AuthenChannelKey
    public var payload: AuthenPayloadRequest
    
    // Login with Social
    public var provider: SocialProvider = .none
    public var socialId: String = ""
    public var displayName: String = ""
    public var avatar: String = ""
    public var email: String = ""
    public var authToken: String = ""
    
    public init() {
        self.objective = .none
        self.channel = .email
        self.payload = AuthenPayloadRequest()
    }
    
    public var paramRegister: [String: Any] {
        return [
            AuthenRequestKey.channel.rawValue: self.channel.rawValue,
            AuthenRequestKey.payload.rawValue: self.payload.param
        ]
    }
    
    public var paramVerificationPassword: [String: Any] {
        return [
            AuthenRequestKey.objective.rawValue: self.objective.rawValue,
            AuthenRequestKey.password.rawValue: self.payload.password
        ]
    }
    
    public var paramRequestOtp: [String: Any] {
        var param: [String: Any] = [
            AuthenRequestKey.objective.rawValue: self.objective.rawValue,
            AuthenRequestKey.channel.rawValue: self.channel.rawValue,
            
        ]
        
        if self.channel == .email {
            param[AuthenRequestKey.payload.rawValue] = self.payload.paramRequestOtpEmail
        } else {
            param[AuthenRequestKey.payload.rawValue] = self.payload.paramRequestOtpMobile
        }
        
        return param
    }
    
    public var paramVerifyOtp: [String: Any] {
        var param: [String: Any] = [
            AuthenRequestKey.objective.rawValue: self.objective.rawValue,
            AuthenRequestKey.channel.rawValue: self.channel.rawValue,
            AuthenRequestKey.refCode.rawValue: self.payload.refCode,
            AuthenRequestKey.otp.rawValue: self.payload.otp
            
        ]
        
        if self.channel == .email {
            param[AuthenRequestKey.payload.rawValue] = self.payload.paramRequestOtpEmail
        } else {
            param[AuthenRequestKey.payload.rawValue] = self.payload.paramRequestOtpMobile
        }
        
        return param
    }
    
    public var paramLoginWithSocial: [String: Any] {
        return [
            AuthenRequestKey.provider.rawValue: self.provider.rawValue,
            AuthenRequestKey.socialId.rawValue: self.socialId,
            AuthenRequestKey.displayName.rawValue: self.displayName,
            AuthenRequestKey.avatar.rawValue: self.avatar,
            AuthenRequestKey.email.rawValue: self.email,
            AuthenRequestKey.authToken.rawValue: self.authToken
        ]
    }
}

public struct AuthenPayloadRequest {
    enum AuthenPayloadKey: String {
        case objective
        case email
        case password
        case countryCode
        case mobileNumber
        case displayName
        case castcleId
        case refCode
        case newPassword
        case otp
    }
    
    public var objective: AuthenObjective
    public var email: String
    public var password: String
    public var newPassword: String
    public var countryCode: String
    public var mobileNumber: String
    public var displayName: String
    public var castcleId: String
    public var refCode: String
    public var otp: String
    
    public init() {
        self.objective = .none
        self.email = ""
        self.password = ""
        self.newPassword = ""
        self.countryCode = ""
        self.mobileNumber = ""
        self.displayName = ""
        self.castcleId = ""
        self.refCode = ""
        self.otp = ""
    }
    
    public var paramCheckEmailExists: [String: Any] {
        return [
            AuthenPayloadKey.email.rawValue: self.email
        ]
    }
    
    public var paramSuggestCastcleId: [String: Any] {
        return [
            AuthenPayloadKey.displayName.rawValue: self.displayName
        ]
    }
    
    public var paramCheckCastcleIdExists: [String: Any] {
        return [
            AuthenPayloadKey.castcleId.rawValue: self.castcleId
        ]
    }
    
    public var param: [String: Any] {
        return [
            AuthenPayloadKey.email.rawValue: self.email,
            AuthenPayloadKey.password.rawValue: self.password,
            AuthenPayloadKey.countryCode.rawValue: self.countryCode,
            AuthenPayloadKey.mobileNumber.rawValue: self.mobileNumber,
            AuthenPayloadKey.displayName.rawValue: self.displayName,
            AuthenPayloadKey.castcleId.rawValue: self.castcleId
        ]
    }
    
    public var paramChangePasswordSubmit: [String: Any] {
        return [
            AuthenPayloadKey.objective.rawValue: self.objective.rawValue,
            AuthenPayloadKey.refCode.rawValue: self.refCode,
            AuthenPayloadKey.newPassword.rawValue: self.newPassword
        ]
    }
    
    public var paramRequestOtpEmail: [String: Any] {
        return [
            AuthenPayloadKey.email.rawValue: self.email
        ]
    }
    
    public var paramRequestOtpMobile: [String: Any] {
        return [
            AuthenPayloadKey.countryCode.rawValue: self.countryCode,
            AuthenPayloadKey.mobileNumber.rawValue: self.mobileNumber
        ]
    }
}
