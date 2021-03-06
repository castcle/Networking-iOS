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
//  NotificationRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 23/9/2564 BE.
//

import Core

public struct NotificationRequest {
    public var uuid: String = ""
    public var firebaseToken: String = ""
    public var platform: String = "ios"
    public var source: NotificationSection = .profile
    public var untilId: String = ""
    public var maxResults: Int = 25

    public init() {
        // Init NotificationRequest
    }

    public var paramRegisterToken: [String: Any] {
        return [
            JsonKey.uuid.rawValue: self.uuid,
            JsonKey.firebaseToken.rawValue: self.firebaseToken,
            JsonKey.platform.rawValue: self.platform
        ]
    }

    public var paramGetNotifications: [String: Any] {
        var param: [String: Any] = [
            JsonKey.source.rawValue: self.source.rawValue,
            JsonKey.maxResults.rawValue: self.maxResults
        ]
        if !self.untilId.isEmpty {
            param[JsonKey.untilId.rawValue] = self.untilId
        }
        return param
    }

    public var paramReadAllNotifications: [String: Any] {
        return [
            JsonKey.source.rawValue: self.source.rawValue
        ]
    }
}
