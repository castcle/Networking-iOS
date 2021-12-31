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

// MARK: - Comment Payload
public enum CommentPayloadKey: String, Codable {
    case payload
}

public class CommentPayload: NSObject {
    public let payload: [Comment]
    
    public init(json: JSON) {
        
        // MARK: - Comment
        let commentJsonArr = json[CommentPayloadKey.payload.rawValue].arrayValue
        var commentArr: [Comment] = []
        for index in (0..<commentJsonArr.count) {
            if index == 0 {
                if commentJsonArr.count == 1 {
                    commentArr.append(Comment(json: commentJsonArr[index], isLast: true))
                } else {
                    commentArr.append(Comment(json: commentJsonArr[index], isFirst: true))
                }
            } else if index == (commentJsonArr.count - 1) {
                commentArr.append(Comment(json: commentJsonArr[index], isLast: true))
            } else {
                commentArr.append(Comment(json: commentJsonArr[index]))
            }
        }
        self.payload = commentArr
    }
}

// MARK: - Comment
public enum CommentKey: String, Codable {
    case id
    case message
    case like
    case author
    case reply
    case metrics
    case participate
    case createdAt
    case updatedAt
}

public class Comment: NSObject {
    public let id: String
    public let message: String
    public let author: Author
    public let reply: [ReplyComment]
    public var metrics: Metric = Metric()
    public var participate: Participate = Participate()
    public let createdAt: String
    public let updatedAt: String
    public var isFirst: Bool
    public var isLast: Bool
    
    public init(json: JSON, isFirst: Bool = false, isLast: Bool = false) {
        self.id = json[CommentKey.id.rawValue].stringValue
        self.message = json[CommentKey.message.rawValue].stringValue
        self.createdAt = json[CommentKey.createdAt.rawValue].stringValue
        self.updatedAt = json[CommentKey.updatedAt.rawValue].stringValue
        self.isFirst = isFirst
        self.isLast = isLast
        
        // MARK: - Object
        self.author = Author(json: JSON(json[CommentKey.author.rawValue].dictionaryObject ?? [:]))
        self.metrics = Metric(json: JSON(json[CommentKey.metrics.rawValue].dictionaryObject ?? [:]))
        self.participate = Participate(json: JSON(json[CommentKey.participate.rawValue].dictionaryObject ?? [:]))
        
        // MARK: - Reply
        self.reply = (json[CommentKey.reply.rawValue].arrayValue).map { ReplyComment(json: $0) }
    }
    
    public var commentDate: Date {
        return Date.stringToDate(str: self.createdAt)
    }
}

// MARK: - Reply Comment
public enum ReplyCommentKey: String, Codable {
    case id
    case message
    case like
    case author
    case createdAt
    case updatedAt
}

public class ReplyComment: NSObject {
    public let id: String
    public let message: String
    public let author: Author
    public var metrics: Metric = Metric()
    public var participate: Participate = Participate()
    public let createdAt: String
    public let updatedAt: String
    
    public init(json: JSON) {
        self.id = json[ReplyCommentKey.id.rawValue].stringValue
        self.message = json[ReplyCommentKey.message.rawValue].stringValue
        self.createdAt = json[ReplyCommentKey.createdAt.rawValue].stringValue
        self.updatedAt = json[ReplyCommentKey.updatedAt.rawValue].stringValue
        
        // MARK: - Object
        self.author = Author(json: JSON(json[ReplyCommentKey.author.rawValue].dictionaryObject ?? [:]))
        self.metrics = Metric(json: JSON(json[CommentKey.metrics.rawValue].dictionaryObject ?? [:]))
        self.participate = Participate(json: JSON(json[CommentKey.participate.rawValue].dictionaryObject ?? [:]))
    }
    
    public var replyDate: Date {
        return Date.stringToDate(str: self.createdAt)
    }
}
