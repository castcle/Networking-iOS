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
//  Farming.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 22/8/2565 BE.
//

import Core
import SwiftyJSON

// MARK: - Farming
public class Farming: NSObject {
    public var id: String = ""
    public var number: Int = 0
    public var content: Content = Content()
    public var balance: FarmingBalance = FarmingBalance()
    public var status: FarmingStatus = .available
    public var createdAt: String = ""

    public override init() {
        // Init ReportSubject
    }

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.number = json[JsonKey.number.rawValue].intValue
        self.content = Content(json: JSON(json[JsonKey.content.rawValue].dictionaryValue))
        self.balance = FarmingBalance(json: JSON(json[JsonKey.balance.rawValue].dictionaryValue))
        self.status = FarmingStatus(rawValue: json[JsonKey.status.rawValue].stringValue) ?? .available
        self.createdAt = json[JsonKey.createdAt.rawValue].stringValue

        // Update Author ref
        let includes = JSON(json[JsonKey.includes.rawValue].dictionaryValue)
        let users = includes[JsonKey.users.rawValue].arrayValue
        UserHelper.shared.updateAuthorRef(users: users)
    }
}

// MARK: - FarmingBalance
public class FarmingBalance: NSObject {
    public var farmed: String = ""
    public var available: String = ""
    public var farming: String = ""
    public var total: String = ""

    public override init() {
        // Init FarmingBalance
    }

    public init(json: JSON) {
        self.farmed = json[JsonKey.farmed.rawValue].stringValue
        self.available = json[JsonKey.available.rawValue].stringValue
        self.farming = json[JsonKey.farming.rawValue].stringValue
        self.total = json[JsonKey.total.rawValue].stringValue
    }
}
