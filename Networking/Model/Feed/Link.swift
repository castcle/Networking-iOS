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
//  Link.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 14/7/2564 BE.
//

import UIKit
import Core
import SwiftyJSON

// MARK: - Link
public class Link: NSObject {
    public var type: LinkType = .other
    public var url: String = ""
    public var title: String = ""
    public var desc: String = ""
    public var imagePreview: String = ""

    public override init() {
        // Init Link
    }

    public init(json: JSON) {
        self.type = LinkType(rawValue: json[JsonKey.type.rawValue].stringValue) ?? .other
        self.url = json[JsonKey.url.rawValue].stringValue
        self.title = json[JsonKey.title.rawValue].stringValue
        self.desc = json[JsonKey.description.rawValue].stringValue
        self.imagePreview = json[JsonKey.imagePreview.rawValue].stringValue
    }
}
