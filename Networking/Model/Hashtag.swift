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
//  Hashtag.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 13/7/2564 BE.
//

import Core
import SwiftyJSON

// MARK: - Hashtag
public class Hashtag: NSObject {
    public let id: String
    public let slug: String
    public let name: String
    public let key: String
    public let rank: Int
    public let trends: String
    public let count: Int
    public let createdAt: String
    public let updatedAt: String
    
    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.slug = json[JsonKey.slug.rawValue].stringValue
        self.name = json[JsonKey.name.rawValue].stringValue
        self.key = json[JsonKey.key.rawValue].stringValue
        self.rank = json[JsonKey.rank.rawValue].intValue
        self.trends = json[JsonKey.trends.rawValue].stringValue
        self.count = json[JsonKey.count.rawValue].intValue
        self.createdAt = json[JsonKey.createdAt.rawValue].stringValue
        self.updatedAt = json[JsonKey.updatedAt.rawValue].stringValue
    }
}
