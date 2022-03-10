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

import RealmSwift

public enum ProviderCreatePage: String {
    case facebook
    case twitter
    case none
}

public struct PageSocialRequest {
    enum PageSocialKey: String {
        case payload
    }
    
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
            PageSocialKey.payload.rawValue: payloadArr
        ]
    }
}

public struct PageSocial {
    enum PageSocialKey: String {
        case payload
        case provider
        case socialId
        case userName
        case displayName
        case overview
        case avatar
        case cover
        case link
        case authToken
    }
    
    public var provider: ProviderCreatePage = .none
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
    
    public var paramPageSocial: [String: Any] {
        return [
            PageSocialKey.provider.rawValue: self.provider.rawValue,
            PageSocialKey.socialId.rawValue: self.socialId,
            PageSocialKey.userName.rawValue: self.userName,
            PageSocialKey.displayName.rawValue: self.displayName,
            PageSocialKey.overview.rawValue: self.overview,
            PageSocialKey.avatar.rawValue: self.avatar,
            PageSocialKey.cover.rawValue: self.cover,
            PageSocialKey.link.rawValue: self.link,
            PageSocialKey.authToken.rawValue: self.authToken
        ]
    }
    
    public var paramConnectSocial: [String: Any] {
        return [
            PageSocialKey.payload.rawValue: [
                PageSocialKey.provider.rawValue: self.provider.rawValue,
                PageSocialKey.socialId.rawValue: self.socialId,
                PageSocialKey.userName.rawValue: self.userName,
                PageSocialKey.displayName.rawValue: self.displayName,
                PageSocialKey.overview.rawValue: self.overview,
                PageSocialKey.avatar.rawValue: self.avatar,
                PageSocialKey.cover.rawValue: self.cover
            ]
        ]
    }
}
