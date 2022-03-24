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
//  RemoteConfig.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 24/3/2565 BE.
//

import Core
import SwiftyJSON

// MARK: - RemoteConfig
public enum RemoteConfigKey: String, Codable {
    case ios
    case android
    case meta
}

public class RemoteConfig: NSObject {
    public var ios: PlatformData = PlatformData()
    public var android: PlatformData = PlatformData()
    public var meta: ConfigMeta = ConfigMeta()
    
    public override init() {
        // Init RemoteConfig
    }
    
    public init(json: JSON) {
        // MARK: - Object
        self.ios = PlatformData(json: JSON(json[RemoteConfigKey.ios.rawValue].dictionaryValue))
        self.android = PlatformData(json: JSON(json[RemoteConfigKey.android.rawValue].dictionaryValue))
        self.meta = ConfigMeta(json: JSON(json[RemoteConfigKey.meta.rawValue].dictionaryValue))
    }
}

// MARK: - PlatformData
public enum PlatformDataKey: String, Codable {
    case url
    case version
}

public class PlatformData: NSObject {
    public var url: String = ""
    public var version: String = ""
    
    public override init() {
        // Init PlatformData
    }
    
    public init(json: JSON) {
        self.url = json[PlatformDataKey.url.rawValue].stringValue
        self.version = json[PlatformDataKey.version.rawValue].stringValue
    }
}

// MARK: - ConfigMeta
public enum ConfigMetaKey: String, Codable {
    case button
    case title
    case message
}

public class ConfigMeta: NSObject {
    public var button: MetaLanguage = MetaLanguage()
    public var title: MetaLanguage = MetaLanguage()
    public var message: MetaLanguage = MetaLanguage()
    
    public override init() {
        // Init PlatformData
    }
    
    public init(json: JSON) {
        // MARK: - Object
        self.button = MetaLanguage(json: JSON(json[ConfigMetaKey.button.rawValue].dictionaryValue))
        self.title = MetaLanguage(json: JSON(json[ConfigMetaKey.title.rawValue].dictionaryValue))
        self.message = MetaLanguage(json: JSON(json[ConfigMetaKey.message.rawValue].dictionaryValue))
    }
}

// MARK: - MetaLanguage
public enum MetaLanguageKey: String, Codable {
    case en
    case th
}

public class MetaLanguage: NSObject {
    public var en: String = ""
    public var th: String = ""
    
    public override init() {
        // Init MetaLanguage
    }
    
    public init(json: JSON) {
        self.en = json[MetaLanguageKey.en.rawValue].stringValue
        self.th = json[MetaLanguageKey.th.rawValue].stringValue
    }
}
