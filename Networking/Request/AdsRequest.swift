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
//  AdsRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 15/2/2565 BE.
//

import Core

public struct AdsRequest {
    // MARK: - Get
    public var untilId: String = ""
    public var maxResults: Int = 25

    // MARK: - Create
    public var boostType: BoostType = .user
    public var castcleId: String = ""
    public var campaignName: String = ""
    public var campaignMessage: String = ""
    public var objective: AdsObjective = .engagement
    public var dailyBudget: Double = 0.0
    public var duration: Int = 0
    public var dailyBidType: DailyBidType = .auto
    public var dailyBidValue: Int = 0
    public var paymentMethod: AdsPaymentType = .token

    public init() {
        // Init AdsRequest
    }

    public var paramGetAds: [String: Any] {
        var param: [String: Any] = [
            JsonKey.maxResults.rawValue: self.maxResults
        ]

        if !self.untilId.isEmpty {
            param[JsonKey.untilId.rawValue] = self.untilId
        }

        return param
    }

    public var paramCreateAdsUser: [String: Any] {
        var param: [String: Any] = [
            JsonKey.castcleId.rawValue: self.castcleId,
            JsonKey.campaignName.rawValue: self.campaignName,
            JsonKey.objective.rawValue: self.objective.rawValue,
            JsonKey.dailyBudget.rawValue: self.dailyBudget,
            JsonKey.duration.rawValue: self.duration,
            JsonKey.dailyBidType.rawValue: self.dailyBidType.rawValue,
            JsonKey.dailyBidValue.rawValue: self.dailyBidValue,
            JsonKey.paymentMethod.rawValue: self.paymentMethod.rawValue
        ]
        if !self.campaignMessage.isEmpty {
            param[JsonKey.campaignMessage.rawValue] = self.campaignMessage
        }
        return param
    }
}
