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
//  Language.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 24/8/2564 BE.
//

import Core
import SwiftyJSON

// MARK: - Language
public class Language: NSObject {
    public let code: String
    public let title: String
    public let display: String
    public var isSelected: Bool

    public override init() {
        self.code = ""
        self.title = ""
        self.display = ""
        self.isSelected = false
    }

    public init(code: String, title: String, display: String) {
        self.code = code
        self.title = title
        self.display = display
        self.isSelected = false
    }

    public init(json: JSON) {
        self.code = json[JsonKey.code.rawValue].stringValue
        self.title = json[JsonKey.title.rawValue].stringValue
        self.display = json[JsonKey.display.rawValue].stringValue
        self.isSelected = false
    }
}

public extension Language {
    func setMock() -> [Language] {
        return [
            Language(code: "en", title: "English", display: "English"),
            Language(code: "th", title: "Thai", display: "?????????????????????"),
            Language(code: "ru", title: "Russian", display: "??????????????"),
            Language(code: "es", title: "Spanish", display: "Espa??ol"),
            Language(code: "pt-PT", title: "Portuguese", display: "Portugu??s"),
            Language(code: "ar", title: "Arabic", display: "??????????????"),
            Language(code: "zh-Hans", title: "Chinese, Simplified", display: "??????"),
            Language(code: "vi", title: "Vietnamese", display: "Ti???ng Vi???t"),
            Language(code: "ja", title: "Japanese", display: "?????????"),
            Language(code: "nl", title: "Dutch", display: "Deutsch"),
            Language(code: "fr", title: "French", display: "fran??ais"),
            Language(code: "uk", title: "Ukrainian", display: "????????????????????"),
            Language(code: "it", title: "Italian", display: "Italiano"),
            Language(code: "ko", title: "Korean", display: "?????????")
        ]
    }
}
