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
//  Participant.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/7/2564 BE.
//

import SwiftyJSON

// MARK: - Participant
public enum ParticipantKey: String, Codable {
    case type
    case id
    case name
    case avatar
}

public enum ParticipantType: String, Codable {
    case people
    case page
    case unknown
}

public class Participant: NSObject {
    public let type: ParticipantType
    public let id: String
    public let name: String
    public let avatar: String
    
    public init(json: JSON) {
        self.type = ParticipantType(rawValue: json[ParticipantKey.type.rawValue].stringValue) ?? .unknown
        self.id = json[ParticipantKey.id.rawValue].stringValue
        self.name = json[ParticipantKey.name.rawValue].stringValue
        self.avatar = json[ParticipantKey.avatar.rawValue].stringValue
    }
}
