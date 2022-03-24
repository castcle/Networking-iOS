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
//  ContentApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 28/9/2564 BE.
//

import Core
import Moya

enum ContentApi {
    case getMeContents(ContentRequest)
    case createContent(String, ContentRequest)
    case likeContent(String)
    case unlikeContent(String)
    case deleteContent(String)
    case recastContent(ContentRequest)
    case unrecastContent(ContentRequest)
    case quotecastContent(ContentRequest)
}

extension ContentApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getMeContents:
            return "/users/me/contents"
        case .createContent(let feature, _):
            return "/contents/\(feature)"
        case .likeContent:
            return "/users/me/likes"
        case .unlikeContent(let contentId):
            return "users/me/likes/\(contentId)"
        case .deleteContent(let contentId):
            return "/contents/\(contentId)"
        case .recastContent(let contentRequest):
            return "/users/\(contentRequest.castcleId)/recast"
        case .unrecastContent(let contentRequest):
            return "/users/\(contentRequest.castcleId)/recast/\(contentRequest.contentId)"
        case .quotecastContent(let contentRequest):
            return "/users/\(contentRequest.castcleId)/quotecast"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMeContents:
            return .get
        case .createContent, .likeContent, .recastContent, .quotecastContent:
            return .post
        case .unlikeContent, .deleteContent, .unrecastContent:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getMeContents(let contentRequest):
            return .requestParameters(parameters: contentRequest.paramGetContent, encoding: URLEncoding.queryString)
        case .createContent(_, let contentRequest):
            return .requestParameters(parameters: contentRequest.paramCreateContent, encoding: JSONEncoding.default)
        case .recastContent(let contentRequest):
            return .requestParameters(parameters: contentRequest.paramRecastContent, encoding: JSONEncoding.default)
        case .quotecastContent(let contentRequest):
            return .requestParameters(parameters: contentRequest.paramQuotecastContent, encoding: JSONEncoding.default)
        case .likeContent(let contentId):
            let param = [
                "contentId": contentId
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        default:
            return.requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ApiHelper.header
    }
}
