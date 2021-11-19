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
//  Liked.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/7/2564 BE.
//

import SwiftyJSON

// MARK: - Liked
public enum LikedKey: String, Codable {
    case count
    case isLike = "liked"
    case participant
}

public class Liked: NSObject {
    public var count: Int = 0
    public var isLike: Bool = false
    public var participant: [Participant] = []
    
    public override init() {
        // Init
    }
    
    public init(json: JSON) {
        self.count = json[LikedKey.count.rawValue].intValue
        self.isLike = json[LikedKey.isLike.rawValue].boolValue
        
        // MARK: - Participant
        self.participant = (json[LikedKey.participant.rawValue].arrayValue).map { Participant(json: $0) }
    }
}
