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
//  PageInfo.swift
//  Networking
//
//  Created by Tanakorn Phoochaliaw on 15/10/2564 BE.
//

import SwiftyJSON

// MARK: - PageInfo
public enum PageInfoKey: String, Codable {
    case id
    case castcleId
    case displayName
    case overview
    case avatar
    case cover
    case links
}

public class PageInfo: NSObject {
    public var id: String = ""
    public var castcleId: String = ""
    public var displayName: String = ""
    public var overview: String = ""
    public var avatar: String = ""
    public var cover: String = ""
    public var links: Social = Social()
    
    public override init() {
        // Init PageInfo
    }
    
    public init(json: JSON) {
        self.id = json[PageInfoKey.id.rawValue].stringValue
        self.castcleId = json[PageInfoKey.castcleId.rawValue].stringValue
        self.displayName = json[PageInfoKey.displayName.rawValue].stringValue
        self.overview = json[PageInfoKey.overview.rawValue].stringValue
        self.avatar = json[PageInfoKey.avatar.rawValue].stringValue
        self.cover = json[PageInfoKey.cover.rawValue].stringValue
        self.links = Social(json: JSON(json[PageInfoKey.links.rawValue].dictionaryValue))
    }
}

// MARK: - Social Link
public enum SocialKey: String, Codable {
    case facebook
    case twitter
    case youtube
    case medium
    case website
}

public class Social: NSObject {
    public var facebook: String = ""
    public var twitter: String = ""
    public var youtube: String = ""
    public var medium: String = ""
    public var website: String = ""
    
    public override init() {
        // Init Social
    }
    
    public init(json: JSON) {
        self.facebook = json[SocialKey.facebook.rawValue].stringValue
        self.twitter = json[SocialKey.twitter.rawValue].stringValue
        self.youtube = json[SocialKey.youtube.rawValue].stringValue
        self.medium = json[SocialKey.medium.rawValue].stringValue
        self.website = json[SocialKey.website.rawValue].stringValue
    }
}
