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
    case updatePageInfo(String, PageRequest)
    case updatePageAvatar(String, PageRequest)
    case updatePageCover(String, PageRequest)
    case getPageInfo(String)
    case getPageContent(String, ContentRequest)
    case getMyPage
    case deletePage(String, PageRequest)
}

extension PageApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .createPage:
            return "/pages"
        case .updatePageInfo(let pageId, _), .updatePageAvatar(let pageId, _), .updatePageCover(let pageId, _):
            return "/pages/\(pageId)"
        case .getPageInfo(let pageId):
            return "/pages/\(pageId)"
        case .getPageContent(let pageId, _):
            return "/pages/\(pageId)/contents"
        case .getMyPage:
            return "/users/me/pages"
        case .deletePage(let pageId, _):
            return "/pages/\(pageId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createPage:
            return .post
        case .updatePageInfo, .updatePageAvatar, .updatePageCover:
            return .put
        case .getPageInfo, .getPageContent, .getMyPage:
            return .get
        case .deletePage:
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
        case .updatePageInfo(_, let pageRequest):
            return .requestParameters(parameters: pageRequest.paramUpdatePage, encoding: JSONEncoding.default)
        case .updatePageAvatar(_, let pageRequest):
            return .requestParameters(parameters: pageRequest.paramUpdatePageAvatar, encoding: JSONEncoding.default)
        case .updatePageCover(_, let pageRequest):
            return .requestParameters(parameters: pageRequest.paramUpdatePageCover, encoding: JSONEncoding.default)
        case .getPageContent(_, let contentRequest):
            return .requestParameters(parameters: contentRequest.paramGetContent, encoding: URLEncoding.queryString)
        case .deletePage(_, let pageRequest):
            return .requestParameters(parameters: pageRequest.paramDeletePage, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ApiHelper.header
    }
}
