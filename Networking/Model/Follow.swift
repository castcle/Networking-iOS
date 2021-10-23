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
//  Follow.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 12/10/2564 BE.
//

import SwiftyJSON

// MARK: - Follow
public enum FollowKey: String, Codable {
    case id
    case castcleId
    case displayName
    case avatar
    case overview
    case verified
    case type
    case count
}

public class Follow: NSObject {
    public let id: String
    public let castcleId: String
    public let displayName: String
    public let avatar: String
    public let overview: String
    public let verified: Verified
    public let type: AuthorType
    public let count: Int
    
    public init(json: JSON) {
        self.id = json[FollowKey.id.rawValue].stringValue
        self.castcleId = json[FollowKey.castcleId.rawValue].stringValue
        self.displayName = json[FollowKey.displayName.rawValue].stringValue
        self.avatar = json[FollowKey.avatar.rawValue].stringValue
        self.overview = json[FollowKey.overview.rawValue].stringValue
        self.type = AuthorType(rawValue: json[FollowKey.type.rawValue].stringValue) ?? .people
        self.count = json[FollowKey.count.rawValue].intValue
        
        // MARK: - Object
        self.verified = Verified(json: JSON(json[FollowKey.verified.rawValue].dictionaryObject ?? [:]))
    }
}
