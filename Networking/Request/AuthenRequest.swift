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
    public var objective: AuthenObjective = .none
    public var provider: SocialType = .unknow
    public var socialId: String = ""
    public var displayName: String = ""
    public var userName: String = ""
    public var avatar: String = ""
    public var email: String = ""
    public var overview: String = ""
    public var cover: String = ""
    public var authToken: String = ""
    public var referral: String = ""
    public var password: String = ""
    public var newPassword: String = ""
    public var castcleId: String = ""
    public var refCode: String = ""
    public var otp: String = ""
    public var countryCode: String = ""
    public var mobileNumber: String = ""

    public init() {
        // Inti AuthenRequest
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

    public var paramRegister: [String: Any] {
        return [
            JsonKey.email.rawValue: self.email,
            JsonKey.password.rawValue: self.password,
            JsonKey.displayName.rawValue: self.displayName,
            JsonKey.castcleId.rawValue: self.castcleId,
            JsonKey.referral.rawValue: self.referral
        ]
    }

    public var paramVerificationPassword: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.email.rawValue: self.email,
            JsonKey.password.rawValue: self.password
        ]
    }

    public var paramRequestOtpWithMobile: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.countryCode.rawValue: self.countryCode,
            JsonKey.mobileNumber.rawValue: self.mobileNumber
        ]
    }

    public var paramRequestOtpWithEmail: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.email.rawValue: self.email
        ]
    }

    public var paramVerifyOtpWithMobile: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.countryCode.rawValue: self.countryCode,
            JsonKey.mobileNumber.rawValue: self.mobileNumber,
            JsonKey.refCode.rawValue: self.refCode,
            JsonKey.otp.rawValue: self.otp
        ]
    }

    public var paramVerifyOtpWithEmail: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.email.rawValue: self.email,
            JsonKey.refCode.rawValue: self.refCode,
            JsonKey.otp.rawValue: self.otp
        ]
    }

    public var paramChangePassword: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.email.rawValue: self.email,
            JsonKey.refCode.rawValue: self.refCode,
            JsonKey.newPassword.rawValue: self.newPassword
        ]
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
