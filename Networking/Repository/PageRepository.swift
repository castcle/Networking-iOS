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
//  Created by Tanakorn Phoochaliaw on 16/9/2564 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol PageRepository {
    func createPage(pageRequest: PageRequest, _ completion: @escaping complate)
    func updatePageInfo(pageId: String, pageRequest: PageRequest, _ completion: @escaping complate)
    func updatePageAvatar(pageId: String, pageRequest: PageRequest, _ completion: @escaping complate)
    func updatePageCover(pageId: String, pageRequest: PageRequest, _ completion: @escaping complate)
    func getPageInfo(pageId: String, _ completion: @escaping complate)
}

public final class PageRepositoryImpl: PageRepository {
    private let pageProvider = MoyaProvider<PageApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()
    
    public init() {
        // MARK: - Init
    }
    
    public func createPage(pageRequest: PageRequest, _ completion: @escaping complate) {
        self.pageProvider.request(.createPage(pageRequest)) { result in
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
    
    public func updatePageInfo(pageId: String, pageRequest: PageRequest, _ completion: @escaping complate) {
        self.pageProvider.request(.updatePageInfo(pageId, pageRequest)) { result in
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
    
    public func updatePageAvatar(pageId: String, pageRequest: PageRequest, _ completion: @escaping complate) {
        self.pageProvider.request(.updatePageAvatar(pageId, pageRequest)) { result in
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
    
    public func updatePageCover(pageId: String, pageRequest: PageRequest, _ completion: @escaping complate) {
        self.pageProvider.request(.updatePageCover(pageId, pageRequest)) { result in
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
    
    public func getPageInfo(pageId: String, _ completion: @escaping complate) {
        self.pageProvider.request(.getPageInfo(pageId)) { result in
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
