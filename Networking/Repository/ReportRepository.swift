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
//  ReportRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 7/12/2564 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol ReportRepository {
    func reportUser(userId: String, _ completion: @escaping complate)
    func reportContent(contentId: String, _ completion: @escaping complate)
    func blockUser(userId: String, _ completion: @escaping complate)
    func unblockUser(userId: String, _ completion: @escaping complate)
}

public final class ReportRepositoryImpl: ReportRepository {
    private let reportProvider = MoyaProvider<ReportApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()
    
    public init() {
        // MARK: - Init
    }
    
    public func reportUser(userId: String, _ completion: @escaping complate) {
        self.reportProvider.request(.reportUser(userId)) { result in
            switch result {
            case .success(let response):
                completion(true, response, false)
//                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
//                    completion(success, response, isRefreshToken)
//                }
            case .failure(let error):
                completion(true, error as! Response, false)
//                completion(false, error as! Response, false)
            }
        }
    }
    
    public func reportContent(contentId: String, _ completion: @escaping complate) {
        self.reportProvider.request(.reportContent(contentId)) { result in
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
    
    public func blockUser(userId: String, _ completion: @escaping complate) {
        self.reportProvider.request(.blockUser(userId)) { result in
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
    
    public func unblockUser(userId: String, _ completion: @escaping complate) {
        self.reportProvider.request(.unblockUser(userId)) { result in
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