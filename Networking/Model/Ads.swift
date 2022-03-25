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

// MARK: - PageInfo
public enum AdsKey: String, Codable {
    case campaignName
    case campaignMessage
    case campaignCode
    case objective
    case dailyBudget
    case duration
    case adStatus
    case boostStatus
    case boostType
    case payload
    case statistics
    case engagement
    case createdAt
    case updatedAt
}

public enum AdsObjective: String {
    case engagement
    case reach
    
    public var detail: String {
        switch self {
        case .engagement:
            return "Get more people to see your Cast or Page"
        case .reach:
            return "Show your ad to the maximum number of people"
        }
    }
    
    public var image: UIImage {
        switch self {
        case .engagement:
            return UIImage.init(icon: .castcle(.engagement), size: CGSize(width: 100, height: 100), textColor: UIColor.Asset.white)
        case .reach:
            return UIImage.init(icon: .castcle(.reach), size: CGSize(width: 100, height: 100), textColor: UIColor.Asset.white)
        }
    }
}

public enum AdStatus: String {
    case processing
    case declinded
    case approved
}

public enum BoostStatus: String {
    case unknown
    case running
    case pause
    case end
}

public enum BoostType: String {
    case page
    case content
}

public enum AdsPaymentType: String {
    case token = "token-wallet"
    case adCredit = "ad-credit"
    
    public var image: UIImage {
        switch self {
        case .token:
            return UIImage.init(icon: .castcle(.wallet), size: CGSize(width: 100, height: 100), textColor: UIColor.Asset.white)
        case .adCredit:
            return UIImage.init(icon: .castcle(.coin), size: CGSize(width: 100, height: 100), textColor: UIColor.Asset.white)
        }
    }
    
    public var display: String {
        switch self {
        case .token:
            return "Token wallet"
        case .adCredit:
            return "Ad credit"
        }
    }
    
    public var notice: String {
        switch self {
        case .token:
            return "Approximate token value in\nUSD 40.32 Learn more"
        case .adCredit:
            return "Note: Ad credit are valid\nuntil 29/12/2020"
        }
    }
}

public class Ads: NSObject {
    public var campaignName: String = ""
    public var campaignMessage: String = ""
    public var campaignCode: String = ""
    public var objective: AdsObjective = .engagement
    public var dailyBudget: Double = 10
    public var duration: Int = 1
    public var adStatus: AdStatus = .processing
    public var boostStatus: BoostStatus = .unknown
    public var boostType: BoostType = .page
//    public var payload: Bool = false
    public var statistics: Statistics = Statistics()
    public var engagement: Engagement = Engagement()
    public var payment: AdsPaymentType = .adCredit
    public var createdAt: String = ""
    public var updatedAt: String = ""
    
    public override init() {
        // Init Ads
    }
    
    public init(json: JSON) {
        self.campaignName = json[AdsKey.campaignName.rawValue].stringValue
        self.campaignMessage = json[AdsKey.campaignMessage.rawValue].stringValue
        self.campaignCode = json[AdsKey.campaignCode.rawValue].stringValue
        self.objective = AdsObjective(rawValue: json[AdsKey.objective.rawValue].stringValue) ?? .engagement
        self.dailyBudget = json[AdsKey.dailyBudget.rawValue].doubleValue
        self.duration = json[AdsKey.duration.rawValue].intValue
        self.adStatus = AdStatus(rawValue: json[AdsKey.adStatus.rawValue].stringValue) ?? .processing
        self.boostStatus = BoostStatus(rawValue: json[AdsKey.boostStatus.rawValue].stringValue) ?? .unknown
        self.boostType = BoostType(rawValue: json[AdsKey.boostType.rawValue].stringValue) ?? .page
        self.createdAt = json[AdsKey.createdAt.rawValue].stringValue
        self.updatedAt = json[AdsKey.updatedAt.rawValue].stringValue
        
        // MARK: - Object
        self.statistics = Statistics(json: JSON(json[AdsKey.statistics.rawValue].dictionaryValue))
        self.engagement = Engagement(json: JSON(json[AdsKey.engagement.rawValue].dictionaryValue))
    }
}

// MARK: - Statistics
public enum StatisticsKey: String, Codable {
    case budgetSpent
    case impression
    case reach
    case cpm = "CPM"
}

public class Statistics: NSObject {
    public var budgetSpent: Double = 0
    public var impression: StatisticsReach = StatisticsReach()
    public var reach: StatisticsReach = StatisticsReach()
    public var cpm: Double = 0
    
    public override init() {
        // Init Statistics
    }
    
    public init(json: JSON) {
        self.budgetSpent = json[StatisticsKey.budgetSpent.rawValue].doubleValue
        self.cpm = json[StatisticsKey.cpm.rawValue].doubleValue
        
        // MARK: - Object
        self.impression = StatisticsReach(json: JSON(json[StatisticsKey.impression.rawValue].dictionaryValue))
        self.reach = StatisticsReach(json: JSON(json[StatisticsKey.reach.rawValue].dictionaryValue))
    }
}

// MARK: - StatisticsReach
public enum StatisticsReachKey: String, Codable {
    case organic
    case paid
}

public class StatisticsReach: NSObject {
    public var organic: Int = 0
    public var paid: Int = 0
    
    public override init() {
        // Init StatisticsReach
    }
    
    public init(json: JSON) {
        self.organic = json[StatisticsReachKey.organic.rawValue].intValue
        self.paid = json[StatisticsReachKey.paid.rawValue].intValue
    }
}

// MARK: - Engagement
public enum EngagementKey: String, Codable {
    case likes
    case comments
    case recast
    case quotecast
    case clicks
    case followerGain
    case farm
    case saved
    case rewardDistributed
}

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
        self.likes = json[EngagementKey.likes.rawValue].intValue
        self.comments = json[EngagementKey.comments.rawValue].intValue
        self.recast = json[EngagementKey.recast.rawValue].intValue
        self.quotecast = json[EngagementKey.quotecast.rawValue].intValue
        self.clicks = json[EngagementKey.clicks.rawValue].intValue
        self.followerGain = json[EngagementKey.followerGain.rawValue].intValue
        self.farm = json[EngagementKey.farm.rawValue].intValue
        self.saved = json[EngagementKey.saved.rawValue].intValue
        self.rewardDistributed = json[EngagementKey.rewardDistributed.rawValue].intValue
    }
}
