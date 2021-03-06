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
//  Feed.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/7/2564 BE.
//

import Core
import SwiftyJSON

// MARK: - Feed
public class Feed: NSObject {
    public var id: String = ""
    public var feature: Feature = Feature()
    public var circle: Circle = Circle()
    public var type: FeedType = .content
    public var content: Content = Content()
    public var userToFollow: [Author] = []
    public var createdAt: String = ""
    public var updatedAt: String = ""

    public override init() {
        // Init
    }

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.type = FeedType(rawValue: json[JsonKey.type.rawValue].stringValue) ?? .content
        self.createdAt = json[JsonKey.createdAt.rawValue].stringValue
        self.updatedAt = json[JsonKey.updatedAt.rawValue].stringValue

        // MARK: - Object
        self.feature = Feature(json: JSON(json[JsonKey.feature.rawValue].dictionaryObject ?? [:]))
        self.circle = Circle(json: JSON(json[JsonKey.circle.rawValue].dictionaryObject ?? [:]))
        self.content = Content(json: JSON(json[JsonKey.payload.rawValue].dictionaryObject ?? [:]))

        // MARK: - User to Follow
        self.userToFollow = (json[JsonKey.payload.rawValue].arrayValue).map { Author(json: $0) }
    }
}
