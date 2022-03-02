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
//  UserHelper.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/9/2564 BE.
//

import Core
import Defaults

public class UserHelper {
    public init() {
        // Init UserHelper
    }
    
    public func updateLocalProfile(user: UserInfo) {
        Defaults[.userId] = user.id
        Defaults[.castcleId] = user.castcleId
        Defaults[.displayName] = user.displayName
        Defaults[.overview] = user.overview
        Defaults[.verifiedEmail] = user.verified.email
        Defaults[.verifiedSocial] = user.verified.social
        Defaults[.verifiedOfficial] = user.verified.official
        Defaults[.verifiedMobile] = user.verified.mobile
        Defaults[.email] = user.email
        Defaults[.dob] = user.dob
        Defaults[.followers] = user.followers.count
        Defaults[.following] = user.following.count
        Defaults[.facebookLink] = user.links.facebook
        Defaults[.twitterLink] = user.links.twitter
        Defaults[.youtubeLink] = user.links.youtube
        Defaults[.mediumLink] = user.links.medium
        Defaults[.websiteLink] = user.links.website
        Defaults[.avatar] = user.images.avatar.thumbnail
        Defaults[.cover] = user.images.cover.fullHd
        Defaults[.passwordNotSet] = user.passwordNotSet
        Defaults[.mobileCountryCode] = user.mobile.countryCode
        Defaults[.mobileNumber] = user.mobile.number
    }
    
    public func clearUserData() {
        Defaults[.userId] = ""
        Defaults[.castcleId] = ""
        Defaults[.displayName] = ""
        Defaults[.overview] = ""
        Defaults[.verifiedEmail] = false
        Defaults[.verifiedSocial] = false
        Defaults[.verifiedOfficial] = false
        Defaults[.verifiedMobile] = false
        Defaults[.email] = ""
        Defaults[.dob] = ""
        Defaults[.followers] = 0
        Defaults[.following] = 0
        Defaults[.facebookLink] = ""
        Defaults[.twitterLink] = ""
        Defaults[.youtubeLink] = ""
        Defaults[.mediumLink] = ""
        Defaults[.websiteLink] = ""
        Defaults[.avatar] = ""
        Defaults[.cover] = ""
        Defaults[.notificationBadges] = 0
        Defaults[.passwordNotSet] = true
        Defaults[.mobileCountryCode] = ""
        Defaults[.mobileNumber] = ""
    }
    
    public func clearSeenContent() {
        Defaults[.seenId] = ""
    }
}
