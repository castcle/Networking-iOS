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
//  ContentRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 28/9/2564 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol ContentRepository {
    func getMeContents(contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
    func getContentDetail(contentId: String, _ completion: @escaping ResponseHandle)
    func createContent(featureSlug: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
    func likeContent(castcleId: String, contentId: String, _ completion: @escaping ResponseHandle)
    func unlikeContent(castcleId: String, contentId: String, _ completion: @escaping ResponseHandle)
    func deleteContent(contentId: String, _ completion: @escaping ResponseHandle)
    func recastContent(contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
    func unrecastContent(contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
    func quotecastContent(contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
    func getQuoteCast(contentId: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
    func getUserLikeContent(contentId: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
    func getUserRecastContent(contentId: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
}

public final class ContentRepositoryImpl: ContentRepository {
    private let contentProvider = MoyaProvider<ContentApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()

    public init() {
        // MARK: - Init
    }

    public func getMeContents(contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.getMeContents(contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func getContentDetail(contentId: String, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.getContentDetail(contentId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func createContent(featureSlug: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.createContent(featureSlug, contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func likeContent(castcleId: String, contentId: String, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.likeContent(castcleId, contentId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func unlikeContent(castcleId: String, contentId: String, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.unlikeContent(castcleId, contentId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func deleteContent(contentId: String, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.deleteContent(contentId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func recastContent(contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.recastContent(contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func unrecastContent(contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.unrecastContent(contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func quotecastContent(contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.quotecastContent(contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func getQuoteCast(contentId: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.getQuoteCast(contentId, contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func getUserLikeContent(contentId: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.getUserLikeContent(contentId, contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func getUserRecastContent(contentId: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.contentProvider.request(.getUserRecastContent(contentId, contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }
}
