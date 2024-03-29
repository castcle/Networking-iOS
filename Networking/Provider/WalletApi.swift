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
    case walletSearch(String, WalletRequest)
    case createShortcutCastcle(String, WalletRequest)
    case sortShortcuts(String, WalletRequest)
    case updateShortcut(String, String, WalletRequest)
    case deleteShortcut(String, String)
    case reviewSendToken(String, WalletRequest)
    case confirmSendToken(String, WalletRequest)
    case walletLookup(String)
    case getWalletHistory(String, WalletRequest)
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
        case .getWalletRecent(let userId):
            return APIs.Wallet.getWalletRecent(userId).path
        case .walletSearch(let userId, _):
            return APIs.Wallet.walletSearch(userId).path
        case .createShortcutCastcle(let accountId, _):
            return APIs.Wallet.createShortcutCastcle(accountId).path
        case .sortShortcuts(let accountId, _):
            return APIs.Wallet.sortShortcuts(accountId).path
        case .updateShortcut(let accountId, let shortcutId, _):
            return APIs.Wallet.updateShortcut(accountId, shortcutId).path
        case .deleteShortcut(let accountId, let shortcutId):
            return APIs.Wallet.deleteShortcut(accountId, shortcutId).path
        case .reviewSendToken(let userId, _):
            return APIs.Wallet.reviewSendToken(userId).path
        case .confirmSendToken(let userId, _):
            return APIs.Wallet.confirmSendToken(userId).path
        case .walletLookup(let userId):
            return APIs.Wallet.walletLookup(userId).path
        case .getWalletHistory(let userId, _):
            return APIs.Wallet.getWalletHistory(userId).path
        }
    }

    var method: Moya.Method {
        switch self {
        case .getQrCode, .getWalletShortcuts, .getWalletRecent, .walletSearch, .walletLookup, .getWalletHistory:
            return .get
        case .createShortcutCastcle, .reviewSendToken, .confirmSendToken:
            return .post
        case .sortShortcuts, .updateShortcut:
            return .put
        case .deleteShortcut:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .getQrCode(_, _, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramGetQrCode, encoding: URLEncoding.queryString)
        case .walletSearch(_, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramWalletSearch, encoding: URLEncoding.queryString)
        case .createShortcutCastcle(_, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramCreateShortcutsCastcle, encoding: JSONEncoding.default)
        case .sortShortcuts(_, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramSortShortcuts, encoding: JSONEncoding.default)
        case .updateShortcut(_, _, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramCreateShortcutsCastcle, encoding: JSONEncoding.default)
        case .reviewSendToken(_, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramReviewSendToken, encoding: JSONEncoding.default)
        case .confirmSendToken(_, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramConfirmSendToken, encoding: JSONEncoding.default)
        case .getWalletHistory(_, let walletRequest):
            return .requestParameters(parameters: walletRequest.paramGetWalletHistory, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ApiHelper.header()
    }
}
