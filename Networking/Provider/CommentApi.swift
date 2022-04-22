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
//  CommentApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 2/9/2564 BE.
//

import Core
import Moya

enum CommentApi {
    case getComments(String, CommentRequest)
    case createComment(String, CommentRequest)
    case replyComment(String, String, CommentRequest)
    case likedComment(String, CommentRequest)
    case unlikedComment(String, String)
    case deleteComment(String, String)
    case deleteReplyComment(String, String, String)
}

extension CommentApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }
    
    var path: String {
        switch self {
        case .getComments(let contentId, _):
            return "/v2/contents/\(contentId)/comments"
        case .createComment(let castcleId, _):
            return "/v2/users/\(castcleId)/comments"
        case .replyComment(let castcleId, let commentId, _):
            return "/v2/users/\(castcleId)/comments/\(commentId)/reply"
        case .likedComment(let castcleId, _):
            return "/v2/users/\(castcleId)/likes-comments"
        case .unlikedComment(let castcleId, let commentId):
            return "/v2/users/\(castcleId)/likes-comments/\(commentId)"
        case .deleteComment(let castcleId, let commentId):
            return "/v2/users/\(castcleId)/comments/\(commentId)"
        case .deleteReplyComment(let castcleId, let commentId, let replyId):
            return "/v2/users/\(castcleId)/comments/\(commentId)/reply/\(replyId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getComments:
            return .get
        case .createComment, .replyComment, .likedComment:
            return .post
        case .deleteComment, .deleteReplyComment, .unlikedComment:
            return .delete
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getComments(_ , let commentRequest):
            return .requestParameters(parameters: commentRequest.paramGetComment, encoding: URLEncoding.queryString)
        case .createComment(_ , let commentRequest):
            return .requestParameters(parameters: commentRequest.paramCreateComment, encoding: JSONEncoding.default)
        case .replyComment(_, _, let commentRequest):
            return .requestParameters(parameters: commentRequest.paramReplyComment, encoding: JSONEncoding.default)
        case .likedComment(_, let commentRequest):
            return .requestParameters(parameters: commentRequest.paramLikedComment, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ApiHelper.header()
    }
}
