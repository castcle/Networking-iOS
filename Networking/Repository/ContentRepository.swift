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
    func getMeContents(contentRequest: ContentRequest, _ completion: @escaping complate)
    func createContent(featureSlug: String, contentRequest: ContentRequest, _ completion: @escaping complate)
    func likeContent(contentId: String, _ completion: @escaping complate)
    func unlikeContent(contentId: String, _ completion: @escaping complate)
    func deleteContent(contentId: String, _ completion: @escaping complate)
    func recastContent(contentRequest: ContentRequest, _ completion: @escaping complate)
    func unrecastContent(contentRequest: ContentRequest, _ completion: @escaping complate)
    func quotecastContent(contentRequest: ContentRequest, _ completion: @escaping complate)
}

public final class ContentRepositoryImpl: ContentRepository {
    private let contentProvider = MoyaProvider<ContentApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()
    
    public init() {
        // MARK: - Init
    }
    
    public func getMeContents(contentRequest: ContentRequest, _ completion: @escaping complate) {
        self.contentProvider.request(.getMeContents(contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func createContent(featureSlug: String, contentRequest: ContentRequest, _ completion: @escaping complate) {
        self.contentProvider.request(.createContent(featureSlug, contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func likeContent(contentId: String, _ completion: @escaping complate) {
        self.contentProvider.request(.likeContent(contentId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func unlikeContent(contentId: String, _ completion: @escaping complate) {
        self.contentProvider.request(.unlikeContent(contentId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func deleteContent(contentId: String, _ completion: @escaping complate) {
        self.contentProvider.request(.deleteContent(contentId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func recastContent(contentRequest: ContentRequest, _ completion: @escaping complate) {
        self.contentProvider.request(.recastContent(contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func unrecastContent(contentRequest: ContentRequest, _ completion: @escaping complate) {
        self.contentProvider.request(.unrecastContent(contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func quotecastContent(contentRequest: ContentRequest, _ completion: @escaping complate) {
        self.contentProvider.request(.quotecastContent(contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
}
