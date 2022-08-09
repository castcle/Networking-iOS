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
    public var reportedStatus: ReportedStatusType = .none
    public var createdAt: String = "2021-11-19T06:41:33.179Z"
    public var updatedAt: String = "2021-11-19T06:41:33.179Z"
    public var isExpand: Bool = false
    public var isOriginalExpand: Bool = false
    public var isShowContentReport: Bool = false

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
                return .postText
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
        } else {
            return .postText
        }
    }

    public init() {
        // Init
    }

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.authorId = json[JsonKey.authorId.rawValue].stringValue
        self.type = ContentType(rawValue: json[JsonKey.type.rawValue].stringValue) ?? .short
        self.message = json[JsonKey.message.rawValue].stringValue
        self.reportedStatus = ReportedStatusType(rawValue: json[JsonKey.reportedStatus.rawValue].stringValue) ?? .none
        self.createdAt = json[JsonKey.createdAt.rawValue].stringValue
        self.updatedAt = json[JsonKey.updatedAt.rawValue].stringValue

        // MARK: - Object
        self.referencedCasts = ReferencedCast(json: JSON(json[JsonKey.referencedCasts.rawValue].dictionaryObject ?? [:]))
        self.metrics = Metric(json: JSON(json[JsonKey.metrics.rawValue].dictionaryObject ?? [:]))
        self.participate = Participate(json: JSON(json[JsonKey.participate.rawValue].dictionaryObject ?? [:]))

        // MARK: - Photo
        let photoJson = JSON(json[JsonKey.photo.rawValue].dictionaryValue)
        self.photo = (photoJson[JsonKey.contents.rawValue].arrayValue).map { ImageInfo(json: $0) }

        // MARK: - Link
        self.link = (json[JsonKey.link.rawValue].arrayValue).map { Link(json: $0) }
    }
}
