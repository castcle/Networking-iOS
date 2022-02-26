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
//  UserApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 30/8/2564 BE.
//

import Core
import Moya

enum UserApi {
    case getAllUser
    
    case getMe
    case updateInfo(String, UserRequest)
    case updateAvatar(String, UserRequest)
    case updateCover(String, UserRequest)
    case updateMobile(UserRequest)
    case delateUser(UserRequest)
    
    case getUser(String)
    case getUserContents(String, ContentRequest)
    
    case getUserFollower(String)
    case getUserFollowing(String)
    
    case follow(String, UserRequest)
    case unfollow(String, String)
}

extension UserApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getAllUser:
            return "/users"
        case .getUser(let userId):
            return "/users/\(userId)"
        case .getUserContents(let userId, _):
            return "/users/\(userId)/contents"
        case .getUserFollower(let userId):
            return "/users/\(userId)/follower"
        case .getUserFollowing(let userId):
            return "/users/\(userId)/following"
        case .follow(let userId, _):
            return "/users/\(userId)/following"
        case .unfollow(let userId, let targetCastcleId):
            return "/users/\(userId)/following/\(targetCastcleId)"
        case .updateMobile:
            return "/users/me/mobile"
        case .updateInfo(let userId, _):
            return "/users/\(userId)"
        case .updateAvatar(let userId, _):
            return "/users/\(userId)"
        case .updateCover(let userId, _):
            return "/users/\(userId)"
        default:
            return "/users/me"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllUser, .getMe, .getUser, .getUserContents, .getUserFollower, .getUserFollowing:
            return .get
        case .updateInfo, .updateAvatar, .updateMobile, .updateCover, .follow:
            return .put
        case .delateUser, .unfollow:
            return .delete
        }
    }
    
    var sampleData: Data {
        return "{\"message\": \"success message\"}".dataEncoded
    }
    
    var task: Task {
        switch self {
        case .getMe:
            let param = [
                "userFields": "link-social"
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .getUser:
            let param = [
                "userFields": "relationships"
            ]
            return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
        case .updateInfo(_, let userRequest):
            return .requestParameters(parameters: userRequest.payload.paramEditUserProfile, encoding: JSONEncoding.default)
        case .updateAvatar(_, let userRequest):
            return .requestParameters(parameters: userRequest.payload.paramEditUserAvatar, encoding: JSONEncoding.default)
        case .updateCover(_, let userRequest):
            return .requestParameters(parameters: userRequest.payload.paramEditUserCover, encoding: JSONEncoding.default)
        case .updateMobile(let userRequest):
            return .requestParameters(parameters: userRequest.paramUpdateMobile, encoding: JSONEncoding.default)
        case .delateUser(let userRequest):
            return .requestParameters(parameters: userRequest.paramDeleteUser, encoding: JSONEncoding.default)
        case .getUserContents(_, let contentRequest):
            return .requestParameters(parameters: contentRequest.paramGetContent, encoding: URLEncoding.queryString)
        case .follow(_, let userRequest):
            return .requestParameters(parameters: userRequest.paramFollowUser, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ApiHelper.header
    }
}
