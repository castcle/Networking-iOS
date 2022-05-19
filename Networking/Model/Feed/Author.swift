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
//  Author.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/7/2564 BE.
//

import Core
import SwiftyJSON

// MARK: - Author
public class Author: NSObject {
    public var type: AuthorType = .people
    public var id: String = ""
    public var castcleId: String = ""
    public var displayName: String = ""
    public var overview: String = ""
    public var avatar: ImageInfo = ImageInfo()
    public var verified: Verified = Verified()
    public var aggregator: Aggregator = Aggregator()
    public var followed: Bool = false
    public var blocking: Bool = false
    public var blocked: Bool = false

    public override init() {
        // Init
    }

    public init(authorRef: AuthorRef) {
        self.id = authorRef.id
        self.type = AuthorType(rawValue: authorRef.type) ?? .people
        self.castcleId = authorRef.castcleId
        self.displayName = authorRef.displayName
        self.followed = authorRef.followed

        // MARK: - Object
        self.verified.official = authorRef.official
        self.avatar.thumbnail = authorRef.avatar
    }

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.type = AuthorType(rawValue: json[JsonKey.type.rawValue].stringValue) ?? .people
        self.castcleId = json[JsonKey.castcleId.rawValue].stringValue
        self.displayName = json[JsonKey.displayName.rawValue].stringValue
        self.overview = json[JsonKey.overview.rawValue].stringValue
        self.followed = json[JsonKey.followed.rawValue].boolValue
        self.blocking = json[JsonKey.blocking.rawValue].boolValue
        self.blocked = json[JsonKey.blocked.rawValue].boolValue

        // MARK: - Object
        self.verified = Verified(json: JSON(json[JsonKey.verified.rawValue].dictionaryObject ?? [:]))
        self.avatar = ImageInfo(json: JSON(json[JsonKey.avatar.rawValue].dictionaryObject ?? [:]))
        self.aggregator = Aggregator(json: JSON(json[JsonKey.aggregator.rawValue].dictionaryObject ?? [:]))
    }
}
