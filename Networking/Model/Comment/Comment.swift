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
//  Comment.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 2/9/2564 BE.
//

import Core
import SwiftyJSON
import RealmSwift

// MARK: - Comment Payload
public class CommentPayload: NSObject {
    public let payload: [Comment]
    public var meta: Meta = Meta()
    
    public init(json: JSON) {
        // MARK: - Comment
        self.payload = (json[JsonKey.payload.rawValue].arrayValue).map { Comment(json: $0) }
        self.meta = Meta(json: JSON(json[JsonKey.meta.rawValue].dictionaryValue))
        let includes = JSON(json[JsonKey.includes.rawValue].dictionaryValue)
        let comments = includes[JsonKey.comments.rawValue].arrayValue
        let users = includes[JsonKey.users.rawValue].arrayValue
        
        let realm = try! Realm()
        comments.forEach { comment in
            try! realm.write {
                let commentRef = CommentRef().initCustom(json: comment)
                realm.add(commentRef, update: .modified)
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

// MARK: - Comment
public class Comment: NSObject {
    public let id: String
    public let message: String
    public let authorId: String
    public var reply: [String]
    public var metrics: Metric = Metric()
    public var participate: Participate = Participate()
    public let createdAt: String
    public let updatedAt: String
    public var isFirst: Bool
    public var isLast: Bool
    
    public init(json: JSON, isFirst: Bool = false, isLast: Bool = false) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.authorId = json[JsonKey.author.rawValue].stringValue
        self.message = json[JsonKey.message.rawValue].stringValue
        self.createdAt = json[JsonKey.createdAt.rawValue].stringValue
        self.updatedAt = json[JsonKey.updatedAt.rawValue].stringValue
        self.isFirst = isFirst
        self.isLast = isLast
        
        // MARK: - Object
        self.metrics = Metric(json: JSON(json[JsonKey.metrics.rawValue].dictionaryObject ?? [:]))
        self.participate = Participate(json: JSON(json[JsonKey.participate.rawValue].dictionaryObject ?? [:]))
        
        // MARK: - Reply
        self.reply = (json[JsonKey.reply.rawValue].arrayValue).map { $0.stringValue }
    }
    
    public var commentDate: Date {
        return Date.stringToDate(str: self.createdAt)
    }
}
