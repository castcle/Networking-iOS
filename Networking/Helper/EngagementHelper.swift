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
//  EngagementHelper.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 13/9/2564 BE.
//

import UIKit
import Core
import SwiftyJSON
import FirebaseAnalytics

public enum EventType: String {
    case startSession = "START_SESSION"
    case endSession = "END_SESSION"
    case onItemView = "ON_ITEM_VIEW"
    case offItemView = "OFF_ITEM_VIEW"
    case onScreenView = "ON_SCREEN_VIEW"
    case offScreenView = "OFF_SCREEN_VIEW"
    case like = "LIKE"
    case unLike = "UN_LIKE"
    case unknown
}

public enum ScreenId: String {
    case splashScreen = "SPLASH_SCREEN"
    case feed = "FEED"
    case content = "CONTENT"
    case newCast = "NEW_CAST"
    case profileTimeline = "PROFILE_TIMELINE"
    case pageTimeline = "PAGE_TIMELINE"
    case viewProfile = "VIEW_PROFILE"
    case search = "SEARCH"
    case photo = "PHOTO"
    case setting = "SETTING"
    case account = "ACCOUNT"
    case resetPassword = "RESET_PASSWORD"
    case syncSocial = "SYNC_SOCIAL"
    case deleteAccount = "DELETE_ACCOUNT"
    case wallet = "WALLET"
    case unknown
}

public class EngagementHelper {
    private var engagementRepository: EngagementRepository = EngagementRepositoryImpl()

    public init() {
        // Init EngagementHelper
    }

    public func seenContent(feedId: String) {
        self.engagementRepository.seenContent(feedId: feedId)
    }

    public func castOffView(feedId: String) {
        self.engagementRepository.castOffView(feedId: feedId)
    }

    public func sendCastcleAnalytic(event: EventType, screen: ScreenId) {
        DispatchQueue.background(background: {
            if event == .onScreenView {
                self.sendFirebaseAnalytic(screen: screen)
            }
        })
    }

    private func sendFirebaseAnalytic(screen: ScreenId) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [AnalyticsParameterScreenName: screen.rawValue])
    }
}
