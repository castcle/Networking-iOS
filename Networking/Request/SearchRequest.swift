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
//  SearchRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 12/10/2564 BE.
//

import Core

public struct SearchRequest {
    enum SearchKey: String {
        case page
        case limit
        case keyword
        case maxResults
        case untilId
        case contentType
        case userFields
    }
    
    public enum SearchContentType: String {
        case photo
        case video
        case none
    }

    public var page: Int = 1
    public var limit: Int = 10
    public var keyword: String = ""
    public var untilId: String = ""
    public var maxResults: Int = 25
    public var type: SearchContentType = .none
    public var userFields: UserFields = .relationships
    
    public init() {
        // Init SearchRequest
    }
    
    public var paramGetTopTrends: [String: Any] {
        return [
            SearchKey.limit.rawValue: self.limit
        ]
    }
    
    public var paramSuggestion: [String: Any] {
        return [
            SearchKey.keyword.rawValue: self.keyword
        ]
    }
    
    public var paramSearch: [String: Any] {
        var param: [String: Any] = [
            SearchKey.keyword.rawValue: self.keyword,
            SearchKey.maxResults.rawValue: self.maxResults,
            SearchKey.userFields.rawValue: self.userFields.rawValue
        ]
        
        if !self.untilId.isEmpty {
            param[SearchKey.untilId.rawValue] = self.untilId
        }
        
        if self.type != .none {
            param[SearchKey.contentType.rawValue] = self.type.rawValue
        }
        
        return param
        
    }
    
    public var paramSearchUser: [String: Any] {
        var param: [String: Any] = [
            SearchKey.keyword.rawValue: self.keyword,
            SearchKey.maxResults.rawValue: self.maxResults,
            SearchKey.userFields.rawValue: self.userFields.rawValue
        ]
        
        if !self.untilId.isEmpty {
            param[SearchKey.untilId.rawValue] = self.untilId
        }
        
        return param
        
    }
}
