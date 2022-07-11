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
//  WalletsRecent.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 11/7/2565 BE.
//

import Core
import SwiftyJSON

// MARK: - WalletsRecent
public class WalletsRecent: NSObject {
    public var id: String = ""
    public var chainId: String = ""
    public var castcleId: String = ""
    public var displayName: String = ""
    public var type: AuthorType = .people
    public var images: UserImage = UserImage()
    public var walletAddress: String = ""
    public var memo: String = ""
    public var createdAt: String = ""
    public var updatedAt: String = ""

    public override init() {
        // Init WalletsRecent
    }

    public init(json: JSON) {
        self.id = json[JsonKey.id.rawValue].stringValue
        self.chainId = json[JsonKey.chainId.rawValue].stringValue
        self.castcleId = json[JsonKey.castcleId.rawValue].stringValue
        self.displayName = json[JsonKey.displayName.rawValue].stringValue
        self.walletAddress = json[JsonKey.walletAddress.rawValue].stringValue
        self.memo = json[JsonKey.memo.rawValue].stringValue
        self.createdAt = json[JsonKey.createdAt.rawValue].stringValue
        self.updatedAt = json[JsonKey.updatedAt.rawValue].stringValue

        // MARK: - Object
        self.type = AuthorType(rawValue: json[JsonKey.type.rawValue].stringValue) ?? .none
        self.images = UserImage(json: JSON(json[JsonKey.images.rawValue].dictionaryValue))
    }
}
