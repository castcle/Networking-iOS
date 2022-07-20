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

import UIKit
import Core
import Defaults
import RealmSwift
import SwiftyJSON

public class UserHelper {
    public static let shared = UserHelper()

    public init() {
        // Init UserHelper
    }

    public func isMyAccount(id: String) -> Bool {
        if id == UserManager.shared.id {
            return true
        } else {
            do {
                let realm = try Realm()
                if realm.objects(Page.self).filter("id = '\(id)'").first != nil {
                    return true
                } else {
                    return false
                }
            } catch {
                return false
            }
        }
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
        Defaults[.avatarFullHd] = user.images.avatar.fullHd
        Defaults[.cover] = user.images.cover.fullHd
        Defaults[.coverFullHd] = user.images.cover.fullHd
        Defaults[.passwordNotSet] = user.passwordNotSet
        Defaults[.canUpdateCastcleId] = user.canUpdateCastcleId
        Defaults[.mobileCountryCode] = user.mobile.countryCode
        Defaults[.mobileNumber] = user.mobile.number
        Defaults[.pdpa] = user.pdpa
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
        Defaults[.avatarFullHd] = ""
        Defaults[.cover] = ""
        Defaults[.coverFullHd] = ""
        Defaults[.passwordNotSet] = true
        Defaults[.canUpdateCastcleId] = false
        Defaults[.mobileCountryCode] = ""
        Defaults[.mobileNumber] = ""
        Defaults[.pdpa] = false
        Defaults[.badgePage] = 0
        Defaults[.badgeProfile] = 0
        Defaults[.badgeSystem] = 0
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    public func setupDataUserLogin(json: JSON) {
        let accessToken = json[JsonKey.accessToken.rawValue].stringValue
        let refreshToken = json[JsonKey.refreshToken.rawValue].stringValue
        let profile = JSON(json[JsonKey.profile.rawValue].dictionaryValue)
        let pages = json[JsonKey.pages.rawValue].arrayValue
        self.updateLocalProfile(user: UserInfo(json: profile))
        self.clearSeenContent()
        NotifyHelper.shared.getBadges()
        self.updatePage(pages: pages)
        UserManager.shared.setUserRole(userRole: .user)
        UserManager.shared.setAccessToken(token: accessToken)
        UserManager.shared.setRefreshToken(token: refreshToken)
    }

    public func clearSeenContent() {
        Defaults[.seenId] = ""
    }

    public func updatePage(pages: [JSON]) {
        do {
            let realm = try Realm()
            let pageRealm = realm.objects(Page.self)
            try realm.write {
                realm.delete(pageRealm)
            }
            try realm.write {
                pages.forEach { page in
                    let pageInfo = UserInfo(json: page)
                    let pageTemp = Page()
                    pageTemp.id = pageInfo.id
                    pageTemp.castcleId = pageInfo.castcleId
                    pageTemp.displayName = pageInfo.displayName
                    pageTemp.avatar = pageInfo.images.avatar.thumbnail
                    pageTemp.cover = pageInfo.images.cover.fullHd
                    pageTemp.overview = pageInfo.overview
                    pageTemp.official = pageInfo.verified.official
                    pageTemp.isSyncTwitter = !pageInfo.syncSocial.twitter.socialId.isEmpty
                    pageTemp.isSyncFacebook = !pageInfo.syncSocial.facebook.socialId.isEmpty
                    realm.add(pageTemp, update: .modified)
                }
            }
        } catch {}
    }

    public func updateAuthorRef(users: [JSON]) {
        do {
            let realm = try Realm()
            try realm.write {
                users.forEach { user in
                    let authorRef = AuthorRef().initCustom(json: user)
                    realm.add(authorRef, update: .modified)
                }
            }
        } catch {}
    }
}
