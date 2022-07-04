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
//  PageSocialRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 4/2/2565 BE.
//

import Core
import RealmSwift
import SwiftyJSON

public struct PageSocialRequest {
    public var payload: [PageSocial] = []

    public init() {
        // Init PageRequest
    }

    public var paramCreatePageWithSocial: [String: Any] {
        var payloadArr: [[String: Any]] = []
        self.payload.forEach { page in
            payloadArr.append(page.paramPageSocial)
        }
        return [
            JsonKey.payload.rawValue: payloadArr
        ]
    }
}

public struct PageSocial {
    public var provider: SocialType = .unknow
    public var socialId: String = ""
    public var userName: String = ""
    public var displayName: String = ""
    public var overview: String = ""
    public var avatar: String = ""
    public var cover: String = ""
    public var link: String = ""
    public var authToken: String = ""

    public init() {
        // Init PageSocial
    }

    public init(json: JSON) {
        self.provider = SocialType(rawValue: json[JsonKey.provider.rawValue].stringValue) ?? .unknow
        self.socialId = json[JsonKey.socialId.rawValue].stringValue
        self.userName = json[JsonKey.userName.rawValue].stringValue
        self.displayName = json[JsonKey.displayName.rawValue].stringValue
        self.overview = json[JsonKey.overview.rawValue].stringValue
        self.avatar = json[JsonKey.avatar.rawValue].stringValue
        self.cover = json[JsonKey.cover.rawValue].stringValue
        self.link = json[JsonKey.link.rawValue].stringValue
        self.authToken = json[JsonKey.authToken.rawValue].stringValue
    }

    public var paramPageSocial: [String: Any] {
        return [
            JsonKey.provider.rawValue: self.provider.rawValue,
            JsonKey.socialId.rawValue: self.socialId,
            JsonKey.userName.rawValue: self.userName,
            JsonKey.displayName.rawValue: self.displayName,
            JsonKey.overview.rawValue: self.overview,
            JsonKey.avatar.rawValue: self.avatar,
            JsonKey.cover.rawValue: self.cover,
            JsonKey.link.rawValue: self.link,
            JsonKey.authToken.rawValue: self.authToken
        ]
    }
}
