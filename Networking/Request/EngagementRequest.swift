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
//  EngagementRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 13/9/2564 BE.
//

import Core

public struct EngagementRequest {
    public var platform: String = "iOS"
    public var client: String = ""
    public var accountId: String = ""
    public var uxSessionId: String = ""
    public var screenId: String = ""
    public var screenInstance: String = ""
    public var feedItemId: String = ""
    public var target: String = ""
    public var targetId: String = ""
    public var eventType: String = ""
    public var eventData: String = ""
    public var timestamp: String = ""
    
    public init() {
        // Init EngagementRequest
    }
    
    public var paramEngagement: [String: Any] {
        return [
            JsonKey.platform.rawValue: self.platform,
            JsonKey.client.rawValue: self.client,
            JsonKey.accountId.rawValue: self.accountId,
            JsonKey.uxSessionId.rawValue: self.uxSessionId,
            JsonKey.screenId.rawValue: self.screenId,
            JsonKey.screenInstance.rawValue: self.screenInstance,
            JsonKey.feedItemId.rawValue: self.feedItemId,
            JsonKey.target.rawValue: self.target,
            JsonKey.targetId.rawValue: self.targetId,
            JsonKey.eventType.rawValue: self.eventType,
            JsonKey.eventData.rawValue: self.eventData,
            JsonKey.timestamp.rawValue: self.timestamp
        ]
    }
}
