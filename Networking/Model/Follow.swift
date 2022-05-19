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

import Core
import SwiftyJSON

// MARK: - Follow
public class Follow: NSObject {
    public let id: String
    public let castcleId: String
    public let displayName: String
    public let avatar: ImageInfo
    public let overview: String
    public let verified: Verified
    public let type: AuthorType
    public let count: Int

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.castcleId = json[JsonKey.castcleId.rawValue].stringValue
        self.displayName = json[JsonKey.displayName.rawValue].stringValue
        self.overview = json[JsonKey.overview.rawValue].stringValue
        self.type = AuthorType(rawValue: json[JsonKey.type.rawValue].stringValue) ?? .people
        self.count = json[JsonKey.count.rawValue].intValue

        // MARK: - Object
        self.verified = Verified(json: JSON(json[JsonKey.verified.rawValue].dictionaryObject ?? [:]))
        self.avatar = ImageInfo(json: JSON(json[JsonKey.avatar.rawValue].dictionaryObject ?? [:]))
    }
}
