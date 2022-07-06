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
//  UserRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 31/8/2564 BE.
//

import Core

public struct UserRequest {
    public var channel: UserChannelKey = .email
    public var payload: UserPayloadRequest = UserPayloadRequest()
    public var targetCastcleId: String = ""
    public var objective: AuthenObjective = .none
    public var refCode: String = ""
    public var countryCode: String = ""
    public var mobileNumber: String = ""

    public init() {
        // Init
    }

    public var paramDeleteUser: [String: Any] {
        return [
            JsonKey.password.rawValue: self.payload.password
        ]
    }

    public var paramFollowUser: [String: Any] {
        return [
            JsonKey.targetCastcleId.rawValue: self.targetCastcleId
        ]
    }

    public var paramUpdateMobile: [String: Any] {
        return [
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.refCode.rawValue: self.refCode,
            JsonKey.countryCode.rawValue: self.countryCode,
            JsonKey.mobileNumber.rawValue: self.mobileNumber
        ]
    }
}

public struct UserPayloadRequest {
    public var password: String = ""
    public var castcleId: String = ""
    public var displayName: String = ""
    public var overview: String = ""
    public var dob: String = ""
    public var contact: ContactRequest = ContactRequest()
    public var images: UserImageRequest = UserImageRequest()
    public var links: UserLinkRequest = UserLinkRequest()

    public init() {
        // Init
    }

    public var paramEditUserProfile: [String: Any] {
        var param: [String: Any] = [:]
        if !self.overview.isEmpty {
            param[JsonKey.overview.rawValue] = self.overview
        }

        if !self.dob.isEmpty {
            param[JsonKey.dob.rawValue] = self.dob
        }

        if !self.links.facebook.isEmpty || !self.links.twitter.isEmpty || !self.links.youtube.isEmpty || !self.links.medium.isEmpty || !self.links.website.isEmpty {
            param[JsonKey.links.rawValue] = self.links.paramEditUserLink
        }

        if !self.castcleId.isEmpty {
            param[JsonKey.castcleId.rawValue] = self.castcleId
        }

        if !self.displayName.isEmpty {
            param[JsonKey.displayName.rawValue] = self.displayName
        }

        if !self.images.avatar.isEmpty || !self.images.cover.isEmpty {
            param[JsonKey.images.rawValue] = self.images.paramEditUserInfo
        }

        if !self.contact.phone.isEmpty || !self.contact.email.isEmpty {
            param[JsonKey.contact.rawValue] = self.contact.paramEditContact
        }
        return param
    }

    public var paramEditUserAvatar: [String: Any] {
        return [
            JsonKey.images.rawValue: self.images.paramEditUserAvatar
        ]
    }

    public var paramEditUserCover: [String: Any] {
        return [
            JsonKey.images.rawValue: self.images.paramEditUserCover
        ]
    }
}

public struct UserImageRequest {
    public var avatar: String = ""
    public var cover: String = ""

    public init() {
        // Init
    }

    public var paramEditUserInfo: [String: Any] {
        var param: [String: Any] = [:]
        if !self.avatar.isEmpty {
            param[JsonKey.avatar.rawValue] = self.avatar
        }
        if !self.cover.isEmpty {
            param[JsonKey.cover.rawValue] = self.cover
        }
        return param
    }

    public var paramEditUserAvatar: [String: Any] {
        return [
            JsonKey.avatar.rawValue: self.avatar
        ]
    }

    public var paramEditUserCover: [String: Any] {
        return [
            JsonKey.cover.rawValue: self.cover
        ]
    }
}

public struct UserLinkRequest {
    public var facebook: String = ""
    public var twitter: String = ""
    public var youtube: String = ""
    public var medium: String = ""
    public var website: String = ""

    public init() {
        // Init
    }

    public var paramEditUserLink: [String: Any] {
        return [
            JsonKey.facebook.rawValue: self.facebook,
            JsonKey.twitter.rawValue: self.twitter,
            JsonKey.youtube.rawValue: self.youtube,
            JsonKey.medium.rawValue: self.medium,
            JsonKey.website.rawValue: self.website
        ]
    }
}

public struct ContactRequest {
    public var countryCode: String = ""
    public var phone: String = ""
    public var email: String = ""

    public init() {
        // Init
    }

    public var paramEditContact: [String: Any] {
        return [
            JsonKey.countryCode.rawValue: self.countryCode,
            JsonKey.phone.rawValue: self.phone,
            JsonKey.email.rawValue: self.email
        ]
    }
}
