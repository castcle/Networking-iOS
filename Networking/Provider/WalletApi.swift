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
//
//  WalletApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 9/6/2565 BE.
//

import Core
import Moya

enum WalletApi {
    case getQrCode(String, String, WalletRequest)
    case getWalletShortcuts(String)
    case getWalletRecent(String)
}

extension WalletApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .getQrCode(let chainId, let userId, _):
            return APIs.Wallet.getQrCode(chainId, userId).path
        case .getWalletShortcuts(let accountId):
            return APIs.Wallet.getWalletShortcuts(accountId).path
        case .getWalletRecent(let accountId):
            return APIs.Wallet.getWalletRecent(accountId).path
        }
    }

    var method: Moya.Method {
        switch self {
        case .getQrCode, .getWalletShortcuts, .getWalletRecent:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getQrCode(_, _, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramGetQrCode, encoding: URLEncoding.queryString)
        case .getWalletShortcuts, .getWalletRecent:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ApiHelper.header()
    }
}
