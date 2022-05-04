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
//  Notify.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 4/5/2565 BE.
//

import Core
import SwiftyJSON

// MARK: - Notification
public class Notify: NSObject {
    public var id: String = ""
    public var source: String = ""
    public var read: Bool = true
    public var type: NotificationType = .none
    public var message: String = ""
    public var landingPage: LandingPage = .none
    public var avatar: ImageInfo = ImageInfo()
    public var commentId: String = ""
    public var contentId: String = ""
    public var profileId: String = ""
    public var createdAt: String = ""
    public var updatedAt: String = ""
    
    public var notifyDate: Date {
        return Date.stringToDate(str: self.updatedAt)
    }
    
    public override init() {
        // Init Notification
    }
    
    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.source = json[JsonKey.source.rawValue].stringValue
        self.read = json[JsonKey.read.rawValue].boolValue
        self.message = json[JsonKey.message.rawValue].stringValue
        self.commentId = json[JsonKey.commentId.rawValue].stringValue
        self.contentId = json[JsonKey.contentId.rawValue].stringValue
        self.profileId = json[JsonKey.profileId.rawValue].stringValue
        self.createdAt = json[JsonKey.createdAt.rawValue].stringValue
        self.updatedAt = json[JsonKey.updatedAt.rawValue].stringValue
        
        // MARK: - Object
        self.type = NotificationType(rawValue: json[JsonKey.type.rawValue].stringValue) ?? .none
        self.landingPage = LandingPage(rawValue: json[JsonKey.landingPage.rawValue].stringValue) ?? .none
        self.avatar = ImageInfo(json: JSON(json[JsonKey.avatar.rawValue].dictionaryValue))
    }
}
