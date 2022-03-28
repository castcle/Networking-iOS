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
//  MasterDataApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 10/2/2565 BE.
//

import Core
import Moya

enum MasterDataApi {
    case getCountry
    case getMentions(String)
    case getHashtag(String)
}

extension MasterDataApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getCountry:
            return "/metadata/country"
        case .getMentions:
            return "/users/me/mentions"
        case .getHashtag:
            return "/metadata/hashtag/search"
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
        case .getMentions(let keyword):
            let param = [
                "keyword": keyword,
                "userFields": "relationships"
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .getHashtag(let keyword):
            let param = [
                "keyword": keyword
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ApiHelper.header(version: "1.0")
    }
}
