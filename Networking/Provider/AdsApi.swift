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
//  AdsApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 15/2/2565 BE.
//

import Core
import Moya

enum AdsApi {
    case getAds(AdsRequest)
    case getAdsDetail(String)
    case createAdsUser(AdsRequest)
    case cancelAds(String)
    case endAds(String)
    case runAds(String)
    case pauseAds(String)
}

extension AdsApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .getAds:
            return APIs.Ads.getAds.path
        case .getAdsDetail(let adsId):
            return APIs.Ads.getAdsDetail(adsId).path
        case .createAdsUser:
            return APIs.Ads.createAdsUser.path
        case .cancelAds(let adsId):
            return APIs.Ads.cancelAds(adsId).path
        case .endAds(let adsId):
            return APIs.Ads.endAds(adsId).path
        case .runAds(let adsId):
            return APIs.Ads.runAds(adsId).path
        case .pauseAds(let adsId):
            return APIs.Ads.pauseAds(adsId).path
        }
    }

    var method: Moya.Method {
        switch self {
        case .getAds, .getAdsDetail:
            return .get
        case .createAdsUser, .cancelAds, .endAds, .runAds, .pauseAds:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getAds(let adsRequest):
            return .requestParameters(parameters: adsRequest.paramGetAds, encoding: URLEncoding.queryString)
        case .createAdsUser(let adsRequest):
            return .requestParameters(parameters: adsRequest.paramCreateAdsUser, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ApiHelper.header()
    }
}
