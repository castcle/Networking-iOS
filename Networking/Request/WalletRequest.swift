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
//  WalletRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 9/6/2565 BE.
//

import Core

public struct WalletRequest {
    public var size: SizeType = .thumbnail
    public var keyword: String = ""
    public var chainId: String = "castcle"
    public var userId: String = ""
    public var address: String = ""
    public var memo: String = ""
    public var amount: String = ""
    public var note: String = ""
    public var castcleId: String = ""
    public var payloadSort: [[String: Any]] = []

    public init() {
        // Init WalletRequest
    }

    public var paramGetQrCode: [String: Any] {
        return [
            JsonKey.size.rawValue: self.size.rawValue
        ]
    }

    public var paramWalletSearch: [String: Any] {
        return [
            JsonKey.keyword.rawValue: self.keyword
        ]
    }

    public var paramCreateShortcutsCastcle: [String: Any] {
        return [
            JsonKey.chainId.rawValue: self.chainId,
            JsonKey.userId.rawValue: self.userId
        ]
    }

    public var paramSortShortcuts: [String: Any] {
        return [
            JsonKey.payload.rawValue: self.payloadSort
        ]
    }

    public var paramReviewSendToken: [String: Any] {
        var param: [String: Any] = [
            JsonKey.chainId.rawValue: self.chainId,
            JsonKey.address.rawValue: self.address,
            JsonKey.amount.rawValue: Float(self.amount) ?? 0.0
        ]
        if !self.memo.isEmpty {
            param[JsonKey.memo.rawValue] = self.memo
        }
        if !self.note.isEmpty {
            param[JsonKey.note.rawValue] = self.note
        }
        return [
            JsonKey.transaction.rawValue: param
        ]
    }
}
