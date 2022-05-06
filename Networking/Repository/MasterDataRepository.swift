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
//  MasterDataRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 10/2/2565 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol MasterDataRepository {
    func getCountry(_ completion: @escaping complate)
    func getMentions(keyword: String, _ completion: @escaping complate)
    func getHashtag(keyword: String, _ completion: @escaping complate)
}

public final class MasterDataRepositoryImpl: MasterDataRepository {
    private let masterDataProvider = MoyaProvider<MasterDataApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()
    
    public init() {
        // MARK: - Init
    }
    
    public func getCountry(_ completion: @escaping complate) {
        self.masterDataProvider.request(.getCountry) { result in
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
    
    public func getMentions(keyword: String, _ completion: @escaping complate) {
        self.masterDataProvider.request(.getMentions(keyword)) { result in
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
    
    public func getHashtag(keyword: String, _ completion: @escaping complate) {
        self.masterDataProvider.request(.getHashtag(keyword)) { result in
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
