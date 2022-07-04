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
//  UserInfo.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/9/2564 BE.
//

import Core
import SwiftyJSON

// MARK: - UserInfo
public class UserInfo {
    public var type: AuthorType = .people
    public var id: String = ""
    public var castcleId: String = ""
    public var displayName: String = ""
    public var email: String = ""
    public var overview: String = ""
    public var dob: String = ""
    public var contact: Contact = Contact()
    public var images: UserImage = UserImage()
    public var links: UserLink = UserLink()
    public var following: UserFollowing = UserFollowing()
    public var followers: UserFollowers = UserFollowers()
    public var verified: Verified = Verified()
    public var aggregator: Aggregator = Aggregator()
    public var followed: Bool = false
    public var blocking: Bool = false
    public var blocked: Bool = false
    public var casts: Int = 0
    public var pdpa: Bool = false
    public var passwordNotSet: Bool = true
    public var linkSocial: LinkSocial = LinkSocial()
    public var mobile: Mobile = Mobile()
    public var syncSocial: SyncSocial = SyncSocial()
    public var canUpdateCastcleId: Bool = false

    public init() {
        // Init UserInfo
    }

    public init(json: JSON) {
        self.type = AuthorType(rawValue: json[JsonKey.type.rawValue].stringValue) ?? .people
        self.id = json[JsonKey.id.rawValue].stringValue
        self.castcleId = json[JsonKey.castcleId.rawValue].stringValue
        self.displayName = json[JsonKey.displayName.rawValue].stringValue
        self.email = json[JsonKey.email.rawValue].stringValue
        self.overview = json[JsonKey.overview.rawValue].stringValue
        self.dob = json[JsonKey.dob.rawValue].stringValue
        self.followed = json[JsonKey.followed.rawValue].boolValue
        self.blocking = json[JsonKey.blocking.rawValue].boolValue
        self.blocked = json[JsonKey.blocked.rawValue].boolValue
        self.casts = json[JsonKey.casts.rawValue].intValue
        self.pdpa = json[JsonKey.pdpa.rawValue].boolValue
        self.passwordNotSet = json[JsonKey.passwordNotSet.rawValue].boolValue
        self.canUpdateCastcleId = json[JsonKey.canUpdateCastcleId.rawValue].boolValue

        // MARK: - Object
        self.images = UserImage(json: JSON(json[JsonKey.images.rawValue].dictionaryObject ?? [:]))
        self.contact = Contact(json: JSON(json[JsonKey.contact.rawValue].dictionaryObject ?? [:]))
        self.links = UserLink(json: JSON(json[JsonKey.links.rawValue].dictionaryObject ?? [:]))
        self.following = UserFollowing(json: JSON(json[JsonKey.following.rawValue].dictionaryObject ?? [:]))
        self.followers = UserFollowers(json: JSON(json[JsonKey.followers.rawValue].dictionaryObject ?? [:]))
        self.verified = Verified(json: JSON(json[JsonKey.verified.rawValue].dictionaryObject ?? [:]))
        self.aggregator = Aggregator(json: JSON(json[JsonKey.aggregator.rawValue].dictionaryObject ?? [:]))
        self.linkSocial = LinkSocial(json: JSON(json[JsonKey.linkSocial.rawValue].dictionaryObject ?? [:]))
        self.mobile = Mobile(json: JSON(json[JsonKey.mobile.rawValue].dictionaryObject ?? [:]))
        self.syncSocial = SyncSocial(json: JSON(json[JsonKey.syncSocial.rawValue].dictionaryObject ?? [:]))
    }

    public init(displayName: String, avatar: String, castcleId: String) {
        self.castcleId = castcleId
        self.displayName = displayName
        self.images.avatar.thumbnail = avatar
    }
}

// MARK: - User Image
public class UserImage {
    public var cover: ImageInfo = ImageInfo()
    public var avatar: ImageInfo = ImageInfo()

    public init() {
        // Init User Image
    }

    public init(json: JSON) {
        self.cover = ImageInfo(json: JSON(json[JsonKey.cover.rawValue].dictionaryObject ?? [:]))
        self.avatar = ImageInfo(json: JSON(json[JsonKey.avatar.rawValue].dictionaryObject ?? [:]))
    }
}

// MARK: - Contact
public class Contact {
    public var countryCode: String = ""
    public var phone: String = ""
    public var email: String = ""

    public init() {
        // Init Contact
    }

    public init(json: JSON) {
        self.countryCode = json[JsonKey.countryCode.rawValue].stringValue
        self.phone = json[JsonKey.phone.rawValue].stringValue
        self.email = json[JsonKey.email.rawValue].stringValue
    }
}

// MARK: - Image Info
public class ImageInfo {
    public var original: String = ""
    public var thumbnail: String = ""
    public var fullHd: String = ""
    public var large: String = ""

    public init() {
        // Init Profile Image
    }

    public init(json: JSON) {
        self.original = json[JsonKey.original.rawValue].stringValue
        self.thumbnail = json[JsonKey.thumbnail.rawValue].stringValue
        self.fullHd = json[JsonKey.fullHd.rawValue].stringValue
        self.large = json[JsonKey.large.rawValue].stringValue
    }
}

// MARK: - User Link
public class UserLink {
    public var facebook: String = ""
    public var twitter: String = ""
    public var youtube: String = ""
    public var medium: String = ""
    public var website: String = ""

    public init() {
        // Init User Link
    }

    public init(json: JSON) {
        self.facebook = json[JsonKey.facebook.rawValue].stringValue
        self.twitter = json[JsonKey.twitter.rawValue].stringValue
        self.youtube = json[JsonKey.youtube.rawValue].stringValue
        self.medium = json[JsonKey.medium.rawValue].stringValue
        self.website = json[JsonKey.website.rawValue].stringValue
    }
}

// MARK: - User Following
public class UserFollowing {
    public var count: Int = 0

    public init() {
        // Init User Following
    }

    public init(json: JSON) {
        self.count = json[JsonKey.count.rawValue].intValue
    }
}

// MARK: - User Following
public class UserFollowers {
    public var count: Int = 0

    public init() {
        // Init User Followers
    }

    public init(json: JSON) {
        self.count = json[JsonKey.count.rawValue].intValue
    }
}

// MARK: - Link Social
public class LinkSocial {
    public var facebook: SocialUser = SocialUser()
    public var twitter: SocialUser = SocialUser()
    public var google: SocialUser = SocialUser()
    public var apple: SocialUser = SocialUser()

    public init() {
        // Init Link Social
    }

    public init(json: JSON) {
        self.facebook = SocialUser(json: JSON(json[JsonKey.facebook.rawValue].dictionaryObject ?? [:]))
        self.twitter = SocialUser(json: JSON(json[JsonKey.twitter.rawValue].dictionaryObject ?? [:]))
        self.google = SocialUser(json: JSON(json[JsonKey.google.rawValue].dictionaryObject ?? [:]))
        self.apple = SocialUser(json: JSON(json[JsonKey.apple.rawValue].dictionaryObject ?? [:]))
    }
}

// MARK: - SocialUser
public class SocialUser {
    public var socialId: String = ""
    public var displayName: String = ""

    public init() {
        // Init SocialUser
    }

    public init(json: JSON) {
        self.socialId = json[JsonKey.socialId.rawValue].stringValue
        self.displayName = json[JsonKey.displayName.rawValue].stringValue
    }
}

// MARK: - Mobile
public class Mobile {
    public var countryCode: String = ""
    public var number: String = ""

    public init() {
        // Init Mobile
    }

    public init(json: JSON) {
        self.countryCode = json[JsonKey.countryCode.rawValue].stringValue
        self.number = json[JsonKey.number.rawValue].stringValue
    }
}

// MARK: - SyncSocial
public class SyncSocial: NSObject {
    public var twitter: SyncDetail = SyncDetail()
    public var facebook: SyncDetail = SyncDetail()

    public override init() {
        // Init Social
    }

    public init(json: JSON) {
        self.twitter = SyncDetail(json: JSON(json[JsonKey.twitter.rawValue].dictionaryObject ?? [:]))
        self.facebook = SyncDetail(json: JSON(json[JsonKey.facebook.rawValue].dictionaryObject ?? [:]))
    }
}

// MARK: - SyncSocial
public class SyncDetail: NSObject {
    public var id: String = ""
    public var provider: SocialType = .unknow
    public var socialId: String = ""
    public var userName: String = ""
    public var displayName: String = ""
    public var avatar: String = ""
    public var active: Bool = false
    public var autoPost: Bool = false

    public override init() {
        // Init Social
    }

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.provider = SocialType(rawValue: json[JsonKey.provider.rawValue].stringValue) ?? .unknow
        self.socialId = json[JsonKey.socialId.rawValue].stringValue
        self.userName = json[JsonKey.userName.rawValue].stringValue
        self.displayName = json[JsonKey.displayName.rawValue].stringValue
        self.avatar = json[JsonKey.avatar.rawValue].stringValue
        self.active = json[JsonKey.active.rawValue].boolValue
        self.autoPost = json[JsonKey.autoPost.rawValue].boolValue
    }
}
