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
//  SearchApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 12/10/2564 BE.
//

import Core
import Moya

enum SearchApi {
    case getTopTrends(SearchRequest)
    case getSuggestion(SearchRequest)
    case searchTrend(SearchRequest)
    case searchRecent(SearchRequest)
    case searchUser(SearchRequest)
}

extension SearchApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .getTopTrends:
            return "/searches/topTrends"
        case .getSuggestion:
            return "/searches"
        case .searchTrend:
            return "/feeds/search/trends"
        case .searchRecent:
            return "/feeds/search/recent"
        case .searchUser:
            return "/users/search"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getTopTrends(let searchRequest):
            return .requestParameters(parameters: searchRequest.paramGetTopTrends, encoding: URLEncoding.queryString)
        case .getSuggestion(let searchRequest):
            return .requestParameters(parameters: searchRequest.paramSuggestion, encoding: URLEncoding.queryString)
        case .searchTrend(let searchRequest):
            return .requestParameters(parameters: searchRequest.paramSearch, encoding: URLEncoding.queryString)
        case .searchRecent(let searchRequest):
            return .requestParameters(parameters: searchRequest.paramSearch, encoding: URLEncoding.queryString)
        case .searchUser(let searchRequest):
            return .requestParameters(parameters: searchRequest.paramSearchUser, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ApiHelper.header(version: "1.0")
    }
}
