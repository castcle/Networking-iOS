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

import SwiftyJSON

// MARK: - UserInfo
public enum UserInfoKey: String, Codable {
    case type
    case id
    case castcleId
    case displayName
    case email
    case overview
    case dob
    case images
    case links
    case following
    case followers
    case verified
    case aggregator
    case followed
    case blocking
    case blocked
    case passwordNotSet
    case linkSocial
    case mobile
    case syncSocial
}

public class UserInfo {
    public var type: AuthorType = .people
    public var id: String = ""
    public var castcleId: String = ""
    public var displayName: String = ""
    public var email: String = ""
    public var overview: String = ""
    public var dob: String = ""
    public var images: UserImage = UserImage()
    public var links: UserLink = UserLink()
    public var following: UserFollowing = UserFollowing()
    public var followers: UserFollowers = UserFollowers()
    public var verified: Verified = Verified()
    public var aggregator: Aggregator = Aggregator()
    public var followed: Bool = false
    public var blocking: Bool = false
    public var blocked: Bool = false
    public var passwordNotSet: Bool = true
    public var linkSocial: LinkSocial = LinkSocial()
    public var mobile: Mobile = Mobile()
    public var syncSocial: SyncSocial = SyncSocial()
    
    public init() {
        // Init UserInfo
    }
    
    public init(json: JSON) {
        self.type = AuthorType(rawValue: json[UserInfoKey.type.rawValue].stringValue) ?? .people
        self.id = json[UserInfoKey.id.rawValue].stringValue
        self.castcleId = json[UserInfoKey.castcleId.rawValue].stringValue
        self.displayName = json[UserInfoKey.displayName.rawValue].stringValue
        self.email = json[UserInfoKey.email.rawValue].stringValue
        self.overview = json[UserInfoKey.overview.rawValue].stringValue
        self.dob = json[UserInfoKey.dob.rawValue].stringValue
        self.followed = json[UserInfoKey.followed.rawValue].boolValue
        self.blocking = json[UserInfoKey.blocking.rawValue].boolValue
        self.blocked = json[UserInfoKey.blocked.rawValue].boolValue
        self.passwordNotSet = json[UserInfoKey.passwordNotSet.rawValue].boolValue
        
        // MARK: - Object
        self.images = UserImage(json: JSON(json[UserInfoKey.images.rawValue].dictionaryObject ?? [:]))
        self.links = UserLink(json: JSON(json[UserInfoKey.links.rawValue].dictionaryObject ?? [:]))
        self.following = UserFollowing(json: JSON(json[UserInfoKey.following.rawValue].dictionaryObject ?? [:]))
        self.followers = UserFollowers(json: JSON(json[UserInfoKey.followers.rawValue].dictionaryObject ?? [:]))
        self.verified = Verified(json: JSON(json[UserInfoKey.verified.rawValue].dictionaryObject ?? [:]))
        self.aggregator = Aggregator(json: JSON(json[UserInfoKey.aggregator.rawValue].dictionaryObject ?? [:]))
        self.linkSocial = LinkSocial(json: JSON(json[UserInfoKey.linkSocial.rawValue].dictionaryObject ?? [:]))
        self.mobile = Mobile(json: JSON(json[UserInfoKey.mobile.rawValue].dictionaryObject ?? [:]))
        self.syncSocial = SyncSocial(json: JSON(json[UserInfoKey.syncSocial.rawValue].dictionaryObject ?? [:]))
    }
}

// MARK: - User Image
public enum UserImageKey: String, Codable {
    case cover
    case avatar
}

public class UserImage {
    public var cover: ImageInfo = ImageInfo()
    public var avatar: ImageInfo = ImageInfo()
    
    public init() {
        // Init User Image
    }
    
    public init(json: JSON) {
        self.cover = ImageInfo(json: JSON(json[UserImageKey.cover.rawValue].dictionaryObject ?? [:]))
        self.avatar = ImageInfo(json: JSON(json[UserImageKey.avatar.rawValue].dictionaryObject ?? [:]))
    }
}

// MARK: - Image Info
public enum ImageInfoKey: String, Codable {
    case original
    case thumbnail
    case fullHd
    case large
}

public class ImageInfo {
    public var original: String = ""
    public var thumbnail: String = ""
    public var fullHd: String = ""
    public var large: String = ""
    
    public init() {
        // Init Profile Image
    }
    
    public init(json: JSON) {
        self.original = json[ImageInfoKey.original.rawValue].stringValue
        self.thumbnail = json[ImageInfoKey.thumbnail.rawValue].stringValue
        self.fullHd = json[ImageInfoKey.fullHd.rawValue].stringValue
        self.large = json[ImageInfoKey.large.rawValue].stringValue
    }
}

// MARK: - User Link
public enum UserLinkKey: String, Codable {
    case facebook
    case twitter
    case youtube
    case medium
    case website
}

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
        self.facebook = json[UserLinkKey.facebook.rawValue].stringValue
        self.twitter = json[UserLinkKey.twitter.rawValue].stringValue
        self.youtube = json[UserLinkKey.youtube.rawValue].stringValue
        self.medium = json[UserLinkKey.medium.rawValue].stringValue
        self.website = json[UserLinkKey.website.rawValue].stringValue
    }
}

// MARK: - User Following
public enum UserFollowingKey: String, Codable {
    case count
}

public class UserFollowing {
    public var count: Int = 0
    
    public init() {
        // Init User Following
    }
    
    public init(json: JSON) {
        self.count = json[UserFollowingKey.count.rawValue].intValue
    }
}

// MARK: - User Following
public enum UserFollowersKey: String, Codable {
    case count
}

public class UserFollowers {
    public var count: Int = 0
    
    public init() {
        // Init User Followers
    }
    
    public init(json: JSON) {
        self.count = json[UserFollowingKey.count.rawValue].intValue
    }
}

// MARK: - Link Social
public enum LinkSocialKey: String, Codable {
    case facebook
    case twitter
    case google
    case apple
}

public class LinkSocial {
    public var facebook: SocialUser = SocialUser()
    public var twitter: SocialUser = SocialUser()
    public var google: SocialUser = SocialUser()
    public var apple: SocialUser = SocialUser()
    
    public init() {
        // Init Link Social
    }
    
    public init(json: JSON) {
        self.facebook = SocialUser(json: JSON(json[LinkSocialKey.facebook.rawValue].dictionaryObject ?? [:]))
        self.twitter = SocialUser(json: JSON(json[LinkSocialKey.twitter.rawValue].dictionaryObject ?? [:]))
        self.google = SocialUser(json: JSON(json[LinkSocialKey.google.rawValue].dictionaryObject ?? [:]))
        self.apple = SocialUser(json: JSON(json[LinkSocialKey.apple.rawValue].dictionaryObject ?? [:]))
    }
}

// MARK: - SocialUser
public enum SocialUserKey: String, Codable {
    case socialId
    case displayName
}

public class SocialUser {
    public var socialId: String = ""
    public var displayName: String = ""
    
    public init() {
        // Init SocialUser
    }
    
    public init(json: JSON) {
        self.socialId = json[SocialUserKey.socialId.rawValue].stringValue
        self.displayName = json[SocialUserKey.displayName.rawValue].stringValue
    }
}

// MARK: - Mobile
public enum MobileKey: String, Codable {
    case countryCode
    case number
}

public class Mobile {
    public var countryCode: String = ""
    public var number: String = ""
    
    public init() {
        // Init SocialUser
    }
    
    public init(json: JSON) {
        self.countryCode = json[MobileKey.countryCode.rawValue].stringValue
        self.number = json[MobileKey.number.rawValue].stringValue
    }
}
