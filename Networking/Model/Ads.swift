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
//  Ads.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 15/2/2565 BE.
//

import UIKit
import Core
import SwiftyJSON

// MARK: - Ads
public class Ads: NSObject {
    public var id: String = ""
    public var campaignName: String = ""
    public var campaignMessage: String = ""
    public var campaignCode: String = ""
    public var objective: AdsObjective = .engagement
    public var dailyBudget: Double = 10
    public var duration: Int = 1
    public var dailyBidType: DailyBidType = .auto
    public var dailyBidValue: Double = 0
    public var adStatus: AdStatus = .processing
    public var boostStatus: BoostStatus = .unknown
    public var boostType: BoostType = .user
    public var user: UserInfo = UserInfo()
    public var content: Content = Content()
    public var statistics: Statistics = Statistics()
    public var engagement: Engagement = Engagement()
    public var payment: AdsPaymentType = .adCredit
    public var createdAt: String = ""
    public var updatedAt: String = ""

    public var createdDisplay: Date {
        return Date.stringToDate(str: self.createdAt)
    }

    public override init() {
        // Init Ads
    }

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.campaignName = json[JsonKey.campaignName.rawValue].stringValue
        self.campaignMessage = json[JsonKey.campaignMessage.rawValue].stringValue
        self.campaignCode = json[JsonKey.campaignCode.rawValue].stringValue
        self.objective = AdsObjective(rawValue: json[JsonKey.objective.rawValue].stringValue) ?? .engagement
        self.dailyBudget = json[JsonKey.dailyBudget.rawValue].doubleValue
        self.duration = json[JsonKey.duration.rawValue].intValue
        self.dailyBidType = DailyBidType(rawValue: json[JsonKey.dailyBidType.rawValue].stringValue) ?? .auto
        self.dailyBidValue = json[JsonKey.dailyBidValue.rawValue].doubleValue
        self.adStatus = AdStatus(rawValue: json[JsonKey.adStatus.rawValue].stringValue) ?? .processing
        self.boostStatus = BoostStatus(rawValue: json[JsonKey.boostStatus.rawValue].stringValue) ?? .unknown
        self.boostType = BoostType(rawValue: json[JsonKey.boostType.rawValue].stringValue) ?? .user
        self.createdAt = json[JsonKey.createdAt.rawValue].stringValue
        self.updatedAt = json[JsonKey.updatedAt.rawValue].stringValue

        // MARK: - Object
        self.statistics = Statistics(json: JSON(json[JsonKey.statistics.rawValue].dictionaryValue))
        self.engagement = Engagement(json: JSON(json[JsonKey.engagement.rawValue].dictionaryValue))
        if self.boostType == .user {
            self.user = UserInfo(json: JSON(json[JsonKey.payload.rawValue].dictionaryValue))
        } else {
            self.content = Content(json: JSON(json[JsonKey.payload.rawValue].dictionaryValue))
        }
    }
}

// MARK: - Statistics
public class Statistics: NSObject {
    public var budgetSpent: Double = 0
    public var impression: StatisticsReach = StatisticsReach()
    public var reach: StatisticsReach = StatisticsReach()
    public var cpm: Double = 0
    public var dailySpent: Double = 0

    public override init() {
        // Init Statistics
    }

    public init(json: JSON) {
        self.budgetSpent = json[JsonKey.budgetSpent.rawValue].doubleValue
        self.cpm = json[JsonKey.cpm.rawValue].doubleValue
        self.dailySpent = json[JsonKey.dailySpent.rawValue].doubleValue

        // MARK: - Object
        self.impression = StatisticsReach(json: JSON(json[JsonKey.impression.rawValue].dictionaryValue))
        self.reach = StatisticsReach(json: JSON(json[JsonKey.reach.rawValue].dictionaryValue))
    }
}

// MARK: - StatisticsReach
public class StatisticsReach: NSObject {
    public var organic: Int = 0
    public var paid: Int = 0

    public override init() {
        // Init StatisticsReach
    }

    public init(json: JSON) {
        self.organic = json[JsonKey.organic.rawValue].intValue
        self.paid = json[JsonKey.paid.rawValue].intValue
    }
}

// MARK: - Engagement
public class Engagement: NSObject {
    public var likes: Int = 0
    public var comments: Int = 0
    public var recast: Int = 0
    public var quotecast: Int = 0
    public var clicks: Int = 0
    public var followerGain: Int = 0
    public var farm: Int = 0
    public var saved: Int = 0
    public var rewardDistributed: Int = 0

    public override init() {
        // Init Engagement
    }

    public init(json: JSON) {
        self.likes = json[JsonKey.likes.rawValue].intValue
        self.comments = json[JsonKey.comments.rawValue].intValue
        self.recast = json[JsonKey.recast.rawValue].intValue
        self.quotecast = json[JsonKey.quotecast.rawValue].intValue
        self.clicks = json[JsonKey.clicks.rawValue].intValue
        self.followerGain = json[JsonKey.followerGain.rawValue].intValue
        self.farm = json[JsonKey.farm.rawValue].intValue
        self.saved = json[JsonKey.saved.rawValue].intValue
        self.rewardDistributed = json[JsonKey.rewardDistributed.rawValue].intValue
    }
}
