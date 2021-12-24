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
//  Content.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 21/7/2564 BE.
//

import Core
import SwiftyJSON

// MARK: - Content
public enum ContentKey: String, Codable {
    case id
    case authorId
    case type
    case message
    case photo
    case link
    case referencedCasts
    case metrics
    case participate
    case createdAt
    case updatedAt
    case contents
}

public enum ContentType: String, Codable {
    case short
    case long
    case blog
    case image
    case shortClip
    case clip
    case live
    case unknow = ""
}

public enum FeedDisplayType {
    case postText
    case postLink
    case postLinkPreview
    case postImageX1
    case postImageX2
    case postImageX3
    case postImageXMore
    case blogImage
    case blogNoImage
}

public class Content {
    public var id: String = ""
    public var authorId: String = ""
    public var type: ContentType = .short
    public var message: String = ""
    public var photo: [ImageInfo] = []
    public var link: [Link] = []
    public var referencedCasts: ReferencedCast = ReferencedCast()
    public var metrics: Metric = Metric()
    public var participate: Participate = Participate()
    public var createdAt: String = "2021-11-19T06:41:33.179Z"
    public var updatedAt: String = "2021-11-19T06:41:33.179Z"
    public var isExpand: Bool = false
    
    public var postDate: Date {
        return Date.stringToDate(str: self.createdAt)
    }
    
    public var feedDisplayType: FeedDisplayType {
        if self.type == .short || self.type == .long {
            if !self.photo.isEmpty {
                if self.photo.count == 1 {
                    return .postImageX1
                } else if self.photo.count == 2 {
                    return .postImageX2
                } else if self.photo.count == 3 {
                    return .postImageX3
                } else {
                    return .postImageXMore
                }
            } else if !self.link.isEmpty {
                if let link = self.link.first {
                    if link.imagePreview.isEmpty {
                        return .postLink
                    } else {
                        return .postLinkPreview
                    }
                } else {
                    return .postLink
                }
            } else {
                if self.message.extractURLs().first != nil {
                    return .postLink
                } else {
                    return .postText
                }
            }
        } else if self.type == .image {
            if self.photo.isEmpty {
                return .postText
            } else {
                if self.photo.count == 1 {
                    return .postImageX1
                } else if self.photo.count == 2 {
                    return .postImageX2
                } else if self.photo.count == 3 {
                    return .postImageX3
                } else {
                    return .postImageXMore
                }
            }
//        } else if self.type == .blog {
//            if self.contentPayload.cover.large.isEmpty {
//                return .blogNoImage
//            } else {
//                return .blogImage
//            }
        } else {
            return .postText
        }
    }
    
    public init() {
        // Init
    }
    
    public init(json: JSON) {
        self.id = json[ContentKey.id.rawValue].stringValue
        self.authorId = json[ContentKey.authorId.rawValue].stringValue
        self.type = ContentType(rawValue: json[ContentKey.type.rawValue].stringValue) ?? .short
        self.message = json[ContentKey.message.rawValue].stringValue
        self.createdAt = json[ContentKey.createdAt.rawValue].stringValue
        self.updatedAt = json[ContentKey.updatedAt.rawValue].stringValue
        
        // MARK: - Object
        self.referencedCasts = ReferencedCast(json: JSON(json[ContentKey.referencedCasts.rawValue].dictionaryObject ?? [:]))
        self.metrics = Metric(json: JSON(json[ContentKey.metrics.rawValue].dictionaryObject ?? [:]))
        self.participate = Participate(json: JSON(json[ContentKey.participate.rawValue].dictionaryObject ?? [:]))
        
        // MARK: - Photo
        let photoJson = JSON(json[ContentKey.photo.rawValue].dictionaryValue)
        self.photo = (photoJson[ContentKey.contents.rawValue].arrayValue).map { ImageInfo(json: $0) }

        // MARK: - Link
        self.link = (json[ContentPayloadKey.link.rawValue].arrayValue).map { Link(json: $0) }
    }
}
