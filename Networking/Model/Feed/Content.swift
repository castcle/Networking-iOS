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
    case type
    case payload
    case feature
    case liked
    case commented
    case recasted
    case quoteCast
    case author
    case created
    case updated
}

public enum ContentType: String, Codable {
    case short
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
    public let id: String
    public let type: ContentType
    public let contentPayload: ContentPayload
    public let feature: Feature
    public let liked: Liked
    public let commented: Commented
    public let recasted: Recasted
//    let quoteCast
    public let author: Author
    public let created: String
    public let updated: String
    
    public var postDate: Date {
        return Date.stringToDate(str: self.created)
    }
    
    public var feedDisplayType: FeedDisplayType {
        if self.type == .short {
            if !self.contentPayload.photo.isEmpty {
                if self.contentPayload.photo.count == 1 {
                    return .postImageX1
                } else if self.contentPayload.photo.count == 2 {
                    return .postImageX2
                } else if self.contentPayload.photo.count == 3 {
                    return .postImageX3
                } else {
                    return .postImageXMore
                }
            } else if !self.contentPayload.link.isEmpty {
                if let link = self.contentPayload.link.first {
                    if link.imagePreview.isEmpty {
                        return .postLink
                    } else {
                        return .postLinkPreview
                    }
                } else {
                    return .postLink
                }
            } else {
                if self.contentPayload.message.detectedFirstLink != nil {
                    return .postLink
                } else {
                    return .postText
                }
            }
        } else if self.type == .image {
            if self.contentPayload.photo.isEmpty {
                return .postText
            } else {
                if self.contentPayload.photo.count == 1 {
                    return .postImageX1
                } else if self.contentPayload.photo.count == 2 {
                    return .postImageX2
                } else if self.contentPayload.photo.count == 3 {
                    return .postImageX3
                } else {
                    return .postImageXMore
                }
            }
        } else if self.type == .blog {
            if self.contentPayload.cover.fullHd.isEmpty {
                return .blogNoImage
            } else {
                return .blogImage
            }
        } else {
            return .postText
        }
    }
    
    public init(json: JSON) {
        self.id = json[ContentKey.id.rawValue].stringValue
        self.type = ContentType(rawValue: json[ContentKey.type.rawValue].stringValue) ?? .short
        self.created = json[ContentKey.created.rawValue].stringValue
        self.updated = json[ContentKey.updated.rawValue].stringValue
        
        // MARK: - Object
        self.contentPayload = ContentPayload(json: JSON(json[ContentKey.payload.rawValue].dictionaryObject ?? [:]))
        self.feature = Feature(json: JSON(json[ContentKey.feature.rawValue].dictionaryObject ?? [:]))
        self.liked = Liked(json: JSON(json[ContentKey.liked.rawValue].dictionaryObject ?? [:]))
        self.commented = Commented(json: JSON(json[ContentKey.commented.rawValue].dictionaryObject ?? [:]))
        self.recasted = Recasted(json: JSON(json[ContentKey.recasted.rawValue].dictionaryObject ?? [:]))
        self.author = Author(json: JSON(json[ContentKey.author.rawValue].dictionaryObject ?? [:]))
    }
}
