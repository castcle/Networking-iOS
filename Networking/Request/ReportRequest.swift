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
//  ReportRequest.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 27/1/2565 BE.
//

import Core

public struct ReportRequest {
    public var message: String = " "
    public var subject: String = ""
    public var targetCastcleId: String = ""
    public var targetContentId: String = ""

    public init() {
        // Init CommentRequest
    }

    public var paramReportUser: [String: Any] {
        return [
            JsonKey.message.rawValue: self.message,
            JsonKey.targetCastcleId.rawValue: self.targetCastcleId,
            JsonKey.subject.rawValue: self.subject
        ]
    }

    public var paramReportContent: [String: Any] {
        return [
            JsonKey.message.rawValue: self.message,
            JsonKey.targetContentId.rawValue: self.targetContentId,
            JsonKey.subject.rawValue: self.subject
        ]
    }

    public var paramBlockUser: [String: Any] {
        return [
            JsonKey.targetCastcleId.rawValue: self.targetCastcleId
        ]
    }
}
