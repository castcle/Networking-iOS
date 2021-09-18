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
//  User.swift
//  Networking
//
//  Created by Tanakorn Phoochaliaw on 14/9/2564 BE.
//

import SwiftyJSON

// MARK: - User
public enum UserKey: String, Codable {
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
    case followed
}

public class User: NSObject {
    public let id: String
    public let castcleId: String
    public let displayName: String
    public let email: String
    public let overview: String
    public let dob: String
    public let images: UserImage
    public let links: UserLink
    public let following: UserFollowing
    public let followers: UserFollowers
    public let verified: Bool
    public let followed: Bool
    
    public init(json: JSON) {
        
        self.id = json[UserKey.id.rawValue].stringValue
        self.castcleId = json[UserKey.castcleId.rawValue].stringValue
        self.displayName = json[UserKey.displayName.rawValue].stringValue
        self.email = json[UserKey.email.rawValue].stringValue
        self.overview = json[UserKey.overview.rawValue].stringValue
        self.dob = json[UserKey.dob.rawValue].stringValue
        self.verified = json[UserKey.verified.rawValue].boolValue
        self.followed = json[UserKey.followed.rawValue].boolValue
        
        // MARK: - Object
        self.images = UserImage(json: JSON(json[UserKey.images.rawValue].dictionaryObject ?? [:]))
        self.links = UserLink(json: JSON(json[UserKey.links.rawValue].dictionaryObject ?? [:]))
        self.following = UserFollowing(json: JSON(json[UserKey.following.rawValue].dictionaryObject ?? [:]))
        self.followers = UserFollowers(json: JSON(json[UserKey.followers.rawValue].dictionaryObject ?? [:]))
    }
}

// MARK: - User Image
public enum UserImageKey: String, Codable {
    case cover
    case avatar
}

public class UserImage: NSObject {
    public let cover: String
    public let avatar: String
    
    public init(json: JSON) {
        self.cover = json[UserImageKey.cover.rawValue].stringValue
        self.avatar = json[UserImageKey.avatar.rawValue].stringValue
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

public class UserLink: NSObject {
    public let facebook: String
    public let twitter: String
    public let youtube: String
    public let medium: String
    public let website: String
    
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

public class UserFollowing: NSObject {
    public let count: Int
    
    public init(json: JSON) {
        self.count = json[UserFollowingKey.count.rawValue].intValue
    }
}

// MARK: - User Following
public enum UserFollowersKey: String, Codable {
    case count
}

public class UserFollowers: NSObject {
    public let count: Int
    
    public init(json: JSON) {
        self.count = json[UserFollowingKey.count.rawValue].intValue
    }
}