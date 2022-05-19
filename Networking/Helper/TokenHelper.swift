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
//  TokenHelper.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 12/9/2564 BE.
//

import Core
import Defaults

public protocol TokenHelperDelegate: AnyObject {
    func didRefreshTokenFinish()
}

public class TokenHelper {

    public var delegate: TokenHelperDelegate?
    public var authenticationRepository: AuthenticationRepository = AuthenticationRepositoryImpl()
    public func refreshToken() {
        self.authenticationRepository.refreshToken { (success, refreshTokenExpired) in
            if success {
                self.delegate?.didRefreshTokenFinish()
            } else {
                if refreshTokenExpired {
                    UserHelper.shared.clearUserData()
                    self.guestLogin()
                    print("refreshTokenExpired")
                }
            }
        }
    }

    public init() {
        // Init helper
    }

    private func guestLogin() {
        self.authenticationRepository.guestLogin(uuid: Defaults[.deviceUuid]) { (success) in
            if success {
                NotificationCenter.default.post(name: .resetApplication, object: nil)
            }
        }
    }
}
