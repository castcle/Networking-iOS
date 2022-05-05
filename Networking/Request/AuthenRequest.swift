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

import Core

public struct AuthenRequest {
    public var objective: AuthenObjective
    public var channel: AuthenChannelKey
    public var payload: AuthenPayloadRequest
    
    // Login with Social
    public var provider: AuthenSocialProvider = .none
    public var socialId: String = ""
    public var displayName: String = ""
    public var userName: String = ""
    public var avatar: String = ""
    public var email: String = ""
    public var overview: String = ""
    public var cover: String = ""
    public var authToken: String = ""
    
    public init() {
        self.objective = .none
        self.channel = .email
        self.payload = AuthenPayloadRequest()
    }
    
    public var paramRegister: [String: Any] {
        return [
            JsonKey.channel.rawValue: self.channel.rawValue,
            JsonKey.payload.rawValue: self.payload.param
        ]
    }
    
    public var paramVerificationPassword: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.password.rawValue: self.payload.password
        ]
    }
    
    public var paramRequestOtp: [String: Any] {
        var param: [String: Any] = [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.channel.rawValue: self.channel.rawValue,
            
        ]
        
        if self.channel == .email {
            param[JsonKey.payload.rawValue] = self.payload.paramRequestOtpEmail
        } else {
            param[JsonKey.payload.rawValue] = self.payload.paramRequestOtpMobile
        }
        
        return param
    }
    
    public var paramRequestOtpWithEmail: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.email.rawValue: self.email,
        ]
    }
    
    public var paramVerifyOtp: [String: Any] {
        var param: [String: Any] = [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.channel.rawValue: self.channel.rawValue,
            JsonKey.refCode.rawValue: self.payload.refCode,
            JsonKey.otp.rawValue: self.payload.otp
        ]
        
        if self.channel == .email {
            param[JsonKey.payload.rawValue] = self.payload.paramRequestOtpEmail
        } else {
            param[JsonKey.payload.rawValue] = self.payload.paramRequestOtpMobile
        }
        
        return param
    }
    
    public var paramLoginWithSocial: [String: Any] {
        return [
            JsonKey.provider.rawValue: self.provider.rawValue,
            JsonKey.socialId.rawValue: self.socialId,
            JsonKey.displayName.rawValue: self.displayName,
            JsonKey.userName.rawValue: self.userName,
            JsonKey.avatar.rawValue: self.avatar,
            JsonKey.email.rawValue: self.email,
            JsonKey.overview.rawValue: self.overview,
            JsonKey.cover.rawValue: self.cover,
            JsonKey.authToken.rawValue: self.authToken
        ]
    }
}

public struct AuthenPayloadRequest {
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
    
    public var paramCheckEmail: [String: Any] {
        return [
            JsonKey.email.rawValue: self.email
        ]
    }
    
    public var paramSuggestCastcleId: [String: Any] {
        return [
            JsonKey.displayName.rawValue: self.displayName
        ]
    }
    
    public var paramCheckCastcleId: [String: Any] {
        return [
            JsonKey.castcleId.rawValue: self.castcleId
        ]
    }
    
    public var param: [String: Any] {
        return [
            JsonKey.email.rawValue: self.email,
            JsonKey.password.rawValue: self.password,
            JsonKey.countryCode.rawValue: self.countryCode,
            JsonKey.mobileNumber.rawValue: self.mobileNumber,
            JsonKey.displayName.rawValue: self.displayName,
            JsonKey.castcleId.rawValue: self.castcleId
        ]
    }
    
    public var paramChangePasswordSubmit: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.refCode.rawValue: self.refCode,
            JsonKey.newPassword.rawValue: self.newPassword
        ]
    }
    
    public var paramRequestOtpEmail: [String: Any] {
        return [
            JsonKey.email.rawValue: self.email
        ]
    }
    
    public var paramRequestOtpMobile: [String: Any] {
        return [
            JsonKey.countryCode.rawValue: self.countryCode,
            JsonKey.mobileNumber.rawValue: self.mobileNumber
        ]
    }
}
