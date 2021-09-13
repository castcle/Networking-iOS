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
//  UserRequest.swift
//  Networking
//
//  Created by Tanakorn Phoochaliaw on 31/8/2564 BE.
//

public enum UserChannelKey: String {
    case email
    case social
}

public struct UserRequest {
    enum UserRequestKey: String {
        case channel
        case payload
    }
    
    public var channel: UserChannelKey
    public var payload: UserPayloadRequest
    
    public init() {
        self.channel = .email
        self.payload = UserPayloadRequest()
    }
    
    public var paramDeleteUser: [String: Any] {
        return [
            UserRequestKey.channel.rawValue: self.channel.rawValue,
            UserRequestKey.payload.rawValue: self.payload.paramDeleteUserWithEmail
        ]
    }
}

public struct UserPayloadRequest {
    enum UserPlayloadKey: String {
        case password
    }
    
    public var password: String
    
    public init() {
        self.password = ""
    }
    
    public var paramDeleteUserWithEmail: [String: Any] {
        return [
            UserPlayloadKey.password.rawValue: self.password
        ]
    }
}
