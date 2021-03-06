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
//  SearchRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 12/10/2564 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol SearchRepository {
    func getTopTrends(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle)
    func getSuggestion(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle)
    func searchTrend(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle)
    func searchRecent(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle)
    func searchUser(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle)
}

public final class SearchRepositoryImpl: SearchRepository {
    private let searchProvider = MoyaProvider<SearchApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()

    public init() {
        // MARK: - Init
    }

    public func getTopTrends(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle) {
        self.searchProvider.request(.getTopTrends(searchRequest)) { result in
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

    public func getSuggestion(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle) {
        self.searchProvider.request(.getSuggestion(searchRequest)) { result in
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

    public func searchTrend(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle) {
        self.searchProvider.request(.searchTrend(searchRequest)) { result in
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

    public func searchRecent(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle) {
        self.searchProvider.request(.searchRecent(searchRequest)) { result in
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

    public func searchUser(searchRequest: SearchRequest, _ completion: @escaping ResponseHandle) {
        self.searchProvider.request(.searchUser(searchRequest)) { result in
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
