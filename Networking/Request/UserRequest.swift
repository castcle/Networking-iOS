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
//  UserRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 31/8/2564 BE.
//

public enum UserChannelKey: String {
    case email
    case social
}

public struct UserRequest {
    enum UserRequestKey: String {
        case channel
        case payload
        case targetCastcleId
    }
    
    public var channel: UserChannelKey
    public var payload: UserPayloadRequest
    public var targetCastcleId: String
    
    public init() {
        self.channel = .email
        self.payload = UserPayloadRequest()
        self.targetCastcleId = ""
    }
    
    public var paramDeleteUser: [String: Any] {
        return [
            UserRequestKey.channel.rawValue: self.channel.rawValue,
            UserRequestKey.payload.rawValue: self.payload.paramDeleteUserWithEmail
        ]
    }
    
    public var paramFollowUser: [String: Any] {
        return [
            UserRequestKey.targetCastcleId.rawValue: self.targetCastcleId
        ]
    }
    
    public var paramUnfollowUser: [String: Any] {
        return [
            UserRequestKey.targetCastcleId.rawValue: self.targetCastcleId
        ]
    }
}

public struct UserPayloadRequest {
    enum UserPlayloadKey: String {
        case password
        case overview
        case dob
        case images
        case links
    }
    
    public var password: String
    public var overview: String
    public var dob: String
    public var images: UserImageRequest
    public var links: UserLinkRequest
    
    public init() {
        self.password = ""
        self.overview = ""
        self.dob = ""
        self.images = UserImageRequest()
        self.links = UserLinkRequest()
    }
    
    public var paramDeleteUserWithEmail: [String: Any] {
        return [
            UserPlayloadKey.password.rawValue: self.password
        ]
    }
    
    public var paramEditUserProfile: [String: Any] {
        return [
            UserPlayloadKey.overview.rawValue: self.overview,
            UserPlayloadKey.dob.rawValue: self.dob,
            UserPlayloadKey.links.rawValue: self.links.paramEditUserLink
        ]
    }
    
    public var paramEditUserAvatar: [String: Any] {
        return [
            UserPlayloadKey.images.rawValue: self.images.paramEditUserAvatar
        ]
    }
    
    public var paramEditUserCover: [String: Any] {
        return [
            UserPlayloadKey.images.rawValue: self.images.paramEditUserCover
        ]
    }
}

public struct UserImageRequest {
    enum UserImageRequestKey: String {
        case avatar
        case cover
    }
    
    public var avatar: String
    public var cover: String
    
    public init() {
        self.avatar = ""
        self.cover = ""
    }
    
    public var paramEditUserAvatar: [String: Any] {
        return [
            UserImageRequestKey.avatar.rawValue: self.avatar
        ]
    }
    
    public var paramEditUserCover: [String: Any] {
        return [
            UserImageRequestKey.cover.rawValue: self.cover
        ]
    }
}

public struct UserLinkRequest {
    enum UserLinkRequestKey: String {
        case facebook
        case twitter
        case youtube
        case medium
        case website
    }
    
    public var facebook: String
    public var twitter: String
    public var youtube: String
    public var medium: String
    public var website: String
    
    public init() {
        self.facebook = ""
        self.twitter = ""
        self.youtube = ""
        self.medium = ""
        self.website = ""
    }
    
    public var paramEditUserLink: [String: Any] {
        return [
            UserLinkRequestKey.facebook.rawValue: self.facebook,
            UserLinkRequestKey.twitter.rawValue: self.twitter,
            UserLinkRequestKey.youtube.rawValue: self.youtube,
            UserLinkRequestKey.medium.rawValue: self.medium,
            UserLinkRequestKey.website.rawValue: self.website
        ]
    }
}
