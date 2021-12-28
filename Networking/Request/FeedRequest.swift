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
//  FeedRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 7/10/2564 BE.
//

public struct FeedRequest {
    enum ContentKey: String {
        case page
        case maxResults
        case untilId
        case hashtag
        case type
        case userFields
    }

    public var untilId: String = ""
    public var maxResults: Int = 25
    public var hashtag: String = ""
    public var type: ContentType = .unknow
    public var userFields: String = "relationships"
    
    public init() {
        // Init FeedRequest
    }
    
    public var paramGetFeed: [String: Any] {
        var param: [String: Any] = [
            ContentKey.maxResults.rawValue: self.maxResults,
            ContentKey.userFields.rawValue: self.userFields
        ]
        
        if !self.untilId.isEmpty {
            param[ContentKey.untilId.rawValue] = self.untilId
        }
        
        if !self.hashtag.isEmpty {
            param[ContentKey.hashtag.rawValue] = self.hashtag
        }
        
        if self.type != .unknow {
            param[ContentKey.type.rawValue] = self.type.rawValue
        }
        
        return param
    }
}
