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
//  PageRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 16/9/2564 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol PageRepository {
    func createPage(pageRequest: PageRequest, _ completion: @escaping ResponseHandle)
    func getMyPage(_ completion: @escaping ResponseHandle)
    func deletePage(pageId: String, pageRequest: PageRequest, _ completion: @escaping ResponseHandle)
    func createPageWithSocial(pageSocialRequest: PageSocialRequest, _ completion: @escaping ResponseHandle)
    func setAutoPost(syncSocialId: String, _ completion: @escaping ResponseHandle)
    func cancelAutoPost(syncSocialId: String, _ completion: @escaping ResponseHandle)
    func reconnectSyncSocial(syncSocialId: String, pageSocial: PageSocial, _ completion: @escaping ResponseHandle)
    func disconnectSyncSocial(syncSocialId: String, _ completion: @escaping ResponseHandle)
}

public final class PageRepositoryImpl: PageRepository {
    private let pageProvider = MoyaProvider<PageApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()

    public init() {
        // MARK: - Init
    }

    public func createPage(pageRequest: PageRequest, _ completion: @escaping ResponseHandle) {
        self.pageProvider.request(.createPage(pageRequest)) { result in
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

    public func getMyPage(_ completion: @escaping ResponseHandle) {
        self.pageProvider.request(.getMyPage) { result in
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

    public func deletePage(pageId: String, pageRequest: PageRequest, _ completion: @escaping ResponseHandle) {
        self.pageProvider.request(.deletePage(pageId, pageRequest)) { result in
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

    public func createPageWithSocial(pageSocialRequest: PageSocialRequest, _ completion: @escaping ResponseHandle) {
        self.pageProvider.request(.createPageWithSocial(pageSocialRequest)) { result in
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

    public func setAutoPost(syncSocialId: String, _ completion: @escaping ResponseHandle) {
        self.pageProvider.request(.setAutoPost(syncSocialId)) { result in
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

    public func cancelAutoPost(syncSocialId: String, _ completion: @escaping ResponseHandle) {
        self.pageProvider.request(.cancelAutoPost(syncSocialId)) { result in
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

    public func reconnectSyncSocial(syncSocialId: String, pageSocial: PageSocial, _ completion: @escaping ResponseHandle) {
        self.pageProvider.request(.reconnectSyncSocial(syncSocialId, pageSocial)) { result in
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

    public func disconnectSyncSocial(syncSocialId: String, _ completion: @escaping ResponseHandle) {
        self.pageProvider.request(.disconnectSyncSocial(syncSocialId)) { result in
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
