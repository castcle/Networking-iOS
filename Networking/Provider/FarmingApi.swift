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
//  FarmingApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 22/8/2565 BE.
//

import Core
import Moya

enum FarmingApi {
    case farmingLookup(String, String)
    case farmingCast(String, String)
    case unfarmingCast(String, String)
    case getFarmingActive
}

extension FarmingApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .farmingLookup(let userId, let contentId):
            return APIs.Farming.farmingLookup(userId, contentId).path
        case .farmingCast(let userId, _):
            return APIs.Farming.farmingCast(userId).path
        case .unfarmingCast(let userId, let farmId):
            return APIs.Farming.unfarmingCast(userId, farmId).path
        case .getFarmingActive:
            return APIs.Farming.getFarmingActive.path
        }
    }

    var method: Moya.Method {
        switch self {
        case .farmingLookup, .getFarmingActive:
            return .get
        case .farmingCast:
            return .post
        case .unfarmingCast:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .farmingCast(_, let contentId):
            let param = [JsonKey.targetContentId.rawValue: contentId]
            return .requestParameters(parameters: param, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ApiHelper.header()
    }
}
