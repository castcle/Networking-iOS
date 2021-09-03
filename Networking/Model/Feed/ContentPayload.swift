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
//  ContentPayload.swift
//  Networking
//
//  Created by Tanakorn Phoochaliaw on 21/7/2564 BE.
//

import Core
import SwiftyJSON

// MARK: - ContentPayload
public enum ContentPayloadKey: String, Codable {
    case header
    case content
    case photo
    case link
    
    // Blog
    case contents
    case cover
    case url
}

public class ContentPayload: NSObject {
    public let header: String
    public let content: String
    public let cover: String
    public let photo: [Photo]
    public let link: [Link]
    
    public init(json: JSON) {
        self.header = json[ContentPayloadKey.header.rawValue].stringValue
        self.content = json[ContentPayloadKey.content.rawValue].stringValue
        
        // MARK: - Photo
        let photoJson = JSON(json[ContentPayloadKey.photo.rawValue].dictionaryValue)
        self.photo = (photoJson[ContentPayloadKey.contents.rawValue].arrayValue).map { Photo(json: $0) }
        
        // MARK: - Cover
        let photoCoverJson = JSON(photoJson[ContentPayloadKey.cover.rawValue].dictionaryValue)
        self.cover = photoCoverJson[ContentPayloadKey.url.rawValue].stringValue
        
        // MARK: - Link
        self.link = (json[ContentPayloadKey.link.rawValue].arrayValue).map { Link(json: $0) }
    }
}
