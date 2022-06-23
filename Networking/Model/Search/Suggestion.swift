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
//  Suggestion.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/10/2564 BE.
//

import Core
import SwiftyJSON

// MARK: - Comment Payload
public class Suggestion: NSObject {
    public var keyword: [Keyword] = []
    public var hashtags: [Hashtag] = []
    public var users: [UserInfo] = []

    public override init() {
        // Init TopTrend
    }

    public init(json: JSON) {
        self.keyword = (json[JsonKey.keyword.rawValue].arrayValue).map { Keyword(json: $0) }
        self.hashtags = (json[JsonKey.hashtags.rawValue].arrayValue).map { Hashtag(json: $0) }
        self.users = (json[JsonKey.users.rawValue].arrayValue).map { UserInfo(json: $0) }
    }
}
