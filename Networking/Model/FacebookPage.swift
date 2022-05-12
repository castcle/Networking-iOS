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
//  FacebookPage.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 4/4/2565 BE.
//

import Swifter

public struct FacebookPage {
    public var id: String = ""
    public var name: String = ""
    public var avatar: String = ""
    public var userName: String = ""
    public var about: String = ""
    public var accessToken: String = ""
    public var cover: String = ""

    public init(json: JSON) {
        self.id = json["id"].string ?? ""
        self.name = json["name"].string ?? ""
        self.userName = json["username"].string ?? ""
        self.about = json["about"].string ?? ""
        self.accessToken = json["access_token"].string ?? ""
        self.avatar = "https://graph.facebook.com/\(self.id)/picture?type=large&access_token=\(self.accessToken)"
        if let cover = json["cover"].object {
            self.cover = cover["source"]?.string ?? ""
        }
    }
}
