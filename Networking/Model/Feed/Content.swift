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
    case originalPost
    case feature
    case liked
    case commented
    case recasted
    case quoteCast
    case author
    case isRecast
    case createdAt
    case updatedAt
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
    public var id: String = ""
    public var type: ContentType = .short
    public var contentPayload: ContentPayload = ContentPayload()
    public var originalPost: OriginalPost = OriginalPost()
    public var feature: Feature = Feature()
    public var liked: Liked = Liked()
    public var commented: Commented = Commented()
    public var recasted: Recasted = Recasted()
    public var quoteCast: QuoteCast = QuoteCast()
    public var author: Author = Author()
    public var createdAt: String = "2021-11-19T06:41:33.179Z"
    public var updatedAt: String = "2021-11-19T06:41:33.179Z"
    public var isRecast: Bool = false
    
    public var postDate: Date {
        return Date.stringToDate(str: self.createdAt)
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
                if self.contentPayload.message.extractURLs().first != nil {
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
            if self.contentPayload.cover.large.isEmpty {
                return .blogNoImage
            } else {
                return .blogImage
            }
        } else {
            return .postText
        }
    }
    
    public init() {
        // Init
    }
    
    public init(json: JSON) {
        self.id = json[ContentKey.id.rawValue].stringValue
        self.type = ContentType(rawValue: json[ContentKey.type.rawValue].stringValue) ?? .short
        self.createdAt = json[ContentKey.createdAt.rawValue].stringValue
        self.updatedAt = json[ContentKey.updatedAt.rawValue].stringValue
        self.isRecast = json[ContentKey.isRecast.rawValue].boolValue
        
        // MARK: - Object
        self.contentPayload = ContentPayload(json: JSON(json[ContentKey.payload.rawValue].dictionaryObject ?? [:]))
        self.originalPost = OriginalPost(json: JSON(json[ContentKey.originalPost.rawValue].dictionaryObject ?? [:]))
        self.feature = Feature(json: JSON(json[ContentKey.feature.rawValue].dictionaryObject ?? [:]))
        self.liked = Liked(json: JSON(json[ContentKey.liked.rawValue].dictionaryObject ?? [:]))
        self.commented = Commented(json: JSON(json[ContentKey.commented.rawValue].dictionaryObject ?? [:]))
        self.recasted = Recasted(json: JSON(json[ContentKey.recasted.rawValue].dictionaryObject ?? [:]))
        self.quoteCast = QuoteCast(json: JSON(json[ContentKey.quoteCast.rawValue].dictionaryObject ?? [:]))
        self.author = Author(json: JSON(json[ContentKey.author.rawValue].dictionaryObject ?? [:]))
    }
}

// MARK: - Original Post
public enum OriginalPostKey: String, Codable {
    case id = "_id"
    case type
    case payload
    case liked
    case commented
    case recasted
    case quoteCast
    case author
    case createdAt
    case updatedAt
}

public class OriginalPost {
    public var id: String = ""
    public var type: ContentType = .short
    public var contentPayload: ContentPayload = ContentPayload()
    public var liked: Liked = Liked()
    public var commented: Commented = Commented()
    public var recasted: Recasted = Recasted()
    public var quoteCast: QuoteCast = QuoteCast()
    public var author: Author = Author()
    public var createdAt: String = "2021-11-19T06:41:33.179Z"
    public var updatedAt: String = "2021-11-19T06:41:33.179Z"
    
    public var postDate: Date {
        return Date.stringToDate(str: self.createdAt)
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
                if self.contentPayload.message.extractURLs().first != nil {
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
            if self.contentPayload.cover.large.isEmpty {
                return .blogNoImage
            } else {
                return .blogImage
            }
        } else {
            return .postText
        }
    }
    
    public init() {
        // Init
    }
    
    public init(json: JSON) {
        self.id = json[OriginalPostKey.id.rawValue].stringValue
        self.type = ContentType(rawValue: json[OriginalPostKey.type.rawValue].stringValue) ?? .short
        self.createdAt = json[OriginalPostKey.createdAt.rawValue].stringValue
        self.updatedAt = json[OriginalPostKey.updatedAt.rawValue].stringValue
        
        // MARK: - Object
        self.contentPayload = ContentPayload(json: JSON(json[OriginalPostKey.payload.rawValue].dictionaryObject ?? [:]))
        self.liked = Liked(json: JSON(json[OriginalPostKey.liked.rawValue].dictionaryObject ?? [:]))
        self.commented = Commented(json: JSON(json[OriginalPostKey.commented.rawValue].dictionaryObject ?? [:]))
        self.recasted = Recasted(json: JSON(json[OriginalPostKey.recasted.rawValue].dictionaryObject ?? [:]))
        self.quoteCast = QuoteCast(json: JSON(json[OriginalPostKey.quoteCast.rawValue].dictionaryObject ?? [:]))
        self.author = Author(json: JSON(json[OriginalPostKey.author.rawValue].dictionaryObject ?? [:]))
    }
}
