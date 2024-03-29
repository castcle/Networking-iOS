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
//  PageApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 16/9/2564 BE.
//

import Core
import Moya

enum PageApi {
    case createPage(PageRequest)
    case getMyPage
    case deletePage(String, PageRequest)
    case createPageWithSocial(PageSocialRequest)
    case setAutoPost(String, String)
    case cancelAutoPost(String, String)
    case disconnectSyncSocial(String, String)
}

extension PageApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .createPage:
            return APIs.Page.createPage.path
        case .getMyPage:
            return APIs.Page.getMyPage.path
        case .deletePage(let pageId, _):
            return APIs.Page.deletePage(pageId).path
        case .createPageWithSocial:
            return APIs.Page.createPageWithSocial.path
        case .setAutoPost(let castcleId, let syncSocialId):
            return APIs.Page.setAutoPost(castcleId, syncSocialId).path
        case .cancelAutoPost(let castcleId, let syncSocialId):
            return APIs.Page.cancelAutoPost(castcleId, syncSocialId).path
        case .disconnectSyncSocial(let castcleId, let syncSocialId):
            return APIs.Page.disconnectSyncSocial(castcleId, syncSocialId).path
        }
    }

    var method: Moya.Method {
        switch self {
        case .createPage, .createPageWithSocial, .setAutoPost:
            return .post
        case .getMyPage:
            return .get
        case .deletePage, .cancelAutoPost, .disconnectSyncSocial:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .createPage(let pageRequest):
            return .requestParameters(parameters: pageRequest.paramCreatePage, encoding: JSONEncoding.default)
        case .deletePage(_, let pageRequest):
            return .requestParameters(parameters: pageRequest.paramDeletePage, encoding: JSONEncoding.default)
        case .createPageWithSocial(let pageSocialRequest):
            return .requestParameters(parameters: pageSocialRequest.paramCreatePageWithSocial, encoding: JSONEncoding.default)
        case .getMyPage:
            let param = [
                JsonKey.userFields.rawValue: UserFields.syncSocial.rawValue
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ApiHelper.header()
    }
}
