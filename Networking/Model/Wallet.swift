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
//  Wallet.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 25/7/2565 BE.
//

import Core
import SwiftyJSON

// MARK: - Wallet
public class Wallet: NSObject {
    public var id: String = ""
    public var castcleId: String = ""
    public var displayName: String = ""
    public var availableBalance: String = "0.0"
    public var adsCredit: String = "0.0"
    public var farmBalance: String = "0.0"
    public var totalBalance: String = "0.0"

    public var availableBalanceNumber: Double {
        return Double(self.availableBalance) ?? 0.0
    }

    public var farmBalanceNumber: Double {
        return Double(self.farmBalance) ?? 0.0
    }

    public var adsCreditNumber: Double {
        return Double(self.adsCredit) ?? 0.0
    }

    public override init() {
        // Init Wallet
    }

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.castcleId = json[JsonKey.castcleId.rawValue].stringValue
        self.displayName = json[JsonKey.displayName.rawValue].stringValue
        self.availableBalance = json[JsonKey.availableBalance.rawValue].stringValue
        self.adsCredit = json[JsonKey.adsCredit.rawValue].stringValue
        self.farmBalance = json[JsonKey.farmBalance.rawValue].stringValue
        self.totalBalance = json[JsonKey.totalBalance.rawValue].stringValue
    }
}
