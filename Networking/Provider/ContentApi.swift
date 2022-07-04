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
    case getContentDetail(String)
    case createContent(String, ContentRequest)
    case likeContent(String, String)
    case unlikeContent(String, String)
    case deleteContent(String)
    case recastContent(ContentRequest)
    case unrecastContent(ContentRequest)
    case quotecastContent(ContentRequest)
    case getQuoteCast(String, ContentRequest)
    case getUserLikeContent(String, ContentRequest)
    case getUserRecastContent(String, ContentRequest)
}

extension ContentApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .getMeContents:
            return APIs.Content.getMeContents.path
        case.getContentDetail(let contentId):
            return APIs.Content.getContentDetail(contentId).path
        case .createContent(let feature, _):
            return APIs.Content.createContent(feature).path
        case .likeContent(let castcleId, _):
            return APIs.Content.likeContent(castcleId).path
        case .unlikeContent(let castcleId, let contentId):
            return APIs.Content.unlikeContent(castcleId, contentId).path
        case .deleteContent(let contentId):
            return APIs.Content.deleteContent(contentId).path
        case .recastContent(let contentRequest):
            return APIs.Content.recastContent(contentRequest.castcleId).path
        case .unrecastContent(let contentRequest):
            return APIs.Content.unrecastContent(contentRequest.castcleId, contentRequest.contentId).path
        case .quotecastContent(let contentRequest):
            return APIs.Content.quotecastContent(contentRequest.castcleId).path
        case .getQuoteCast(let contentId, _):
            return APIs.Content.getQuoteCast(contentId).path
        case .getUserLikeContent(let contentId, _):
            return APIs.Content.getUserLikeContent(contentId).path
        case .getUserRecastContent(let contentId, _):
            return APIs.Content.getUserRecastContent(contentId).path
        }
    }

    var method: Moya.Method {
        switch self {
        case .getMeContents, .getContentDetail, .getQuoteCast, .getUserLikeContent, .getUserRecastContent:
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
            return .requestParameters(parameters: contentRequest.commonParamGetData, encoding: URLEncoding.queryString)
        case .getContentDetail:
            let param = [
                JsonKey.userFields.rawValue: UserFields.relationships.rawValue
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .createContent(_, let contentRequest):
            return .requestParameters(parameters: contentRequest.paramCreateContent, encoding: JSONEncoding.default)
        case .recastContent(let contentRequest):
            return .requestParameters(parameters: contentRequest.paramRecastContent, encoding: JSONEncoding.default)
        case .quotecastContent(let contentRequest):
            return .requestParameters(parameters: contentRequest.paramQuotecastContent, encoding: JSONEncoding.default)
        case .likeContent(_, let contentId):
            let param = [
                JsonKey.contentId.rawValue: contentId
            ]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        case .getQuoteCast(_, let contentRequest):
            return .requestParameters(parameters: contentRequest.paramGetQuoteCast, encoding: URLEncoding.queryString)
        case .getUserLikeContent(_, let contentRequest):
            return .requestParameters(parameters: contentRequest.commonParamGetData, encoding: URLEncoding.queryString)
        case .getUserRecastContent(_, let contentRequest):
            return .requestParameters(parameters: contentRequest.commonParamGetData, encoding: URLEncoding.queryString)
        default:
            return.requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getMeContents, .likeContent, .unlikeContent, .getQuoteCast, .createContent, .getContentDetail, .deleteContent:
            return ApiHelper.header()
        default:
            return ApiHelper.header(version: "1.0")
        }
    }
}
