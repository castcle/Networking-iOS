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
//  PageRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 16/9/2564 BE.
//

public struct PageRequest {
    enum PageKey: String {
        case payload
        case castcleId
        case displayName
        case avatar
        case cover
        case overview
        case links
        case password
    }
    
    public var castcleId: String = ""
    public var displayName: String = ""
    public var avatar: String = ""
    public var cover: String = ""
    public var overview: String = ""
    public var links: PageLinkRequest = PageLinkRequest()
    public var password: String = ""
    
    public init() {
        // Init PageRequest
    }
    
    public var paramCreatePage: [String: Any] {
        return [
            PageKey.castcleId.rawValue: self.castcleId,
            PageKey.displayName.rawValue: self.displayName
        ]
    }
    
    public var paramUpdatePageAvatar: [String: Any] {
        return [
            PageKey.avatar.rawValue: self.avatar
        ]
    }
    
    public var paramUpdatePageCover: [String: Any] {
        return [
            PageKey.cover.rawValue: self.cover
        ]
    }
    
    public var paramUpdatePage: [String: Any] {
        return [
            PageKey.overview.rawValue: self.overview,
            PageKey.links.rawValue: self.links.paramEditPageLink
        ]
    }
    
    public var paramDeletePage: [String: Any] {
        return [
            PageKey.password.rawValue: self.password
        ]
    }
}

public struct PageLinkRequest {
    enum PageLinkRequestKey: String {
        case facebook
        case twitter
        case youtube
        case medium
        case website
    }
    
    public var facebook: String
    public var twitter: String
    public var youtube: String
    public var medium: String
    public var website: String
    
    public init() {
        self.facebook = ""
        self.twitter = ""
        self.youtube = ""
        self.medium = ""
        self.website = ""
    }
    
    public var paramEditPageLink: [String: Any] {
        return [
            PageLinkRequestKey.facebook.rawValue: self.facebook,
            PageLinkRequestKey.twitter.rawValue: self.twitter,
            PageLinkRequestKey.youtube.rawValue: self.youtube,
            PageLinkRequestKey.medium.rawValue: self.medium,
            PageLinkRequestKey.website.rawValue: self.website
        ]
    }
}
