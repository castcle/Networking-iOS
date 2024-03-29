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
//  AdsRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 15/2/2565 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol AdsRepository {
    func getAds(adsRequest: AdsRequest, _ completion: @escaping ResponseHandle)
    func getAdsDetail(adsId: String, _ completion: @escaping ResponseHandle)
    func createAdsUser(adsRequest: AdsRequest, _ completion: @escaping ResponseHandle)
    func cancelAds(adsId: String, _ completion: @escaping ResponseHandle)
    func endAds(adsId: String, _ completion: @escaping ResponseHandle)
    func runAds(adsId: String, _ completion: @escaping ResponseHandle)
    func pauseAds(adsId: String, _ completion: @escaping ResponseHandle)
}

public final class AdsRepositoryImpl: AdsRepository {
    private let adsProvider = MoyaProvider<AdsApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()

    public init() {
        // MARK: - Init
    }

    public func getAds(adsRequest: AdsRequest, _ completion: @escaping ResponseHandle) {
        self.adsProvider.request(.getAds(adsRequest)) { result in
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

    public func getAdsDetail(adsId: String, _ completion: @escaping ResponseHandle) {
        self.adsProvider.request(.getAdsDetail(adsId)) { result in
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

    public func createAdsUser(adsRequest: AdsRequest, _ completion: @escaping ResponseHandle) {
        self.adsProvider.request(.createAdsUser(adsRequest)) { result in
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

    public func cancelAds(adsId: String, _ completion: @escaping ResponseHandle) {
        self.adsProvider.request(.cancelAds(adsId)) { result in
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

    public func endAds(adsId: String, _ completion: @escaping ResponseHandle) {
        self.adsProvider.request(.endAds(adsId)) { result in
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

    public func runAds(adsId: String, _ completion: @escaping ResponseHandle) {
        self.adsProvider.request(.runAds(adsId)) { result in
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

    public func pauseAds(adsId: String, _ completion: @escaping ResponseHandle) {
        self.adsProvider.request(.pauseAds(adsId)) { result in
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
