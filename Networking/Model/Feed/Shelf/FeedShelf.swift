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
//  FeedShelf.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/7/2564 BE.
//

import Core
import SwiftyJSON
import RealmSwift

// MARK: - Hashtag List
public class FeedShelf: NSObject {
    public var feeds: [Feed] = []
    public var meta: Meta = Meta()
    
    public override init() {
        // MARK: - Init
    }
    
    public init(json: JSON) {
        self.feeds = (json[JsonKey.payload.rawValue].arrayValue).map { Feed(json: $0) }.filter { $0.content.participate.reported == false }
        self.meta = Meta(json: JSON(json[JsonKey.meta.rawValue].dictionaryValue))
        let includes = JSON(json[JsonKey.includes.rawValue].dictionaryValue)
        let casts = includes[JsonKey.casts.rawValue].arrayValue
        let users = includes[JsonKey.users.rawValue].arrayValue
        
        let realm = try! Realm()
        casts.forEach { cast in
            try! realm.write {
                let contentRef = ContentRef().initCustom(json: cast)
                realm.add(contentRef, update: .modified)
            }
        }
        users.forEach { user in
            try! realm.write {
                let authorRef = AuthorRef().initCustom(json: user)
                realm.add(authorRef, update: .modified)
            }
        }
    }
}
