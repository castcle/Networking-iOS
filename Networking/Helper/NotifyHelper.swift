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
//  NotifyHelper.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 5/5/2565 BE.
//

import UIKit
import Core
import RealmSwift

public class NotifyHelper {
    public static let shared = NotifyHelper()
    private var notificationRepository: NotificationRepository = NotificationRepositoryImpl()
    private let tokenHelper: TokenHelper = TokenHelper()
    private var state: State = .none

    public func getBadges() {
        self.state = .getBadges
        self.tokenHelper.delegate = self
        self.notificationRepository.getBadges { (success, _, isRefreshToken) in
            if success {
                UIApplication.shared.applicationIconBadgeNumber = UserManager.shared.badgeCount
            } else {
                if isRefreshToken {
                    self.tokenHelper.refreshToken()
                }
            }
        }
    }
}

extension NotifyHelper: TokenHelperDelegate {
    public func didRefreshTokenFinish() {
        self.getBadges()
    }
}
