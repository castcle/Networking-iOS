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
//  WalletRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 9/6/2565 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol WalletRepository {
    func getQrCode(chainId: String, userId: String, walletRequest: WalletRequest, _ completion: @escaping ResponseHandle)
    func getWalletShortcuts(accountId: String, _ completion: @escaping ResponseHandle)
}

public final class WalletRepositoryImpl: WalletRepository {
    private let walletProvider = MoyaProvider<WalletApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()

    public init() {
        // MARK: - Init
    }

    public func getQrCode(chainId: String, userId: String, walletRequest: WalletRequest, _ completion: @escaping ResponseHandle) {
        self.walletProvider.request(.getQrCode(chainId, userId, walletRequest)) { result in
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

    public func getWalletShortcuts(accountId: String, _ completion: @escaping ResponseHandle) {
        self.walletProvider.request(.getWalletShortcuts(accountId)) { result in
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
