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
//  ContentRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 28/9/2564 BE.
//

import Core

public struct ContentRequest {
    public var type: ContentType = .unknow
    public var untilId: String = ""
    public var maxResults: Int = 25
    public var payload: ContentPayloadRequest = ContentPayloadRequest()
    public var castcleId: String = ""
    public var feedItemId: String = ""
    public var contentId: String = ""
    public var message: String = ""
    public var userFields: UserFields = .relationships

    public init() {
        // Init ContentRequest
    }

    public var paramGetContent: [String: Any] {
        var param: [String: Any] = [
            JsonKey.type.rawValue: self.type.rawValue,
            JsonKey.maxResults.rawValue: self.maxResults,
            JsonKey.userFields.rawValue: self.userFields.rawValue
        ]

        if !self.untilId.isEmpty {
            param[JsonKey.untilId.rawValue] = self.untilId
        }

        return param
    }

    public var paramCreateContent: [String: Any] {
        return [
            JsonKey.type.rawValue: self.type.rawValue,
            JsonKey.payload.rawValue: self.payload.paramCreateShotContent,
            JsonKey.castcleId.rawValue: self.castcleId
        ]
    }

    public var paramRecastContent: [String: Any] {
        return [
            JsonKey.contentId.rawValue: self.contentId
        ]
    }

    public var paramQuotecastContent: [String: Any] {
        return [
            JsonKey.contentId.rawValue: self.contentId,
            JsonKey.message.rawValue: self.message
        ]
    }
}

public struct ContentPayloadRequest {
    public var message: String = ""
    public var image: [String] = []

    public init() {
        // Init ContentPayloadRequest
    }

    public var paramCreateShotContent: [String: Any] {
        return [
            JsonKey.message.rawValue: self.message,
            JsonKey.photo.rawValue: [
                JsonKey.contents.rawValue: self.photoParam
            ]
        ]
    }

    private var photoParam: [[String: String]] {
        var temp: [[String: String]] = []
        self.image.forEach { imageBase64 in
            temp.append([JsonKey.image.rawValue: imageBase64])
        }
        return temp
    }
}
