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
//  Completion.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 30/8/2564 BE.
//

import Core
import Moya
import SwiftyJSON

public typealias ResponseHandle = (_ complate: Bool, _ response: Response, _ isRefreshToken: Bool) -> Void

public let errorRefreshToken: String = "1003"
public let errorRefreshTokenExpired: String = "1004"
public let errorEmailIsAlreadyInCastcle: String = "3021"

public class CompletionHelper {
    func handleNetworingResponse(isSocialLogin: Bool = false, response: Response, _ completion: @escaping ResponseHandle) {
        if response.statusCode < 300 {
            completion(true, response, false)
        } else {
            do {
                let rawJson = try response.mapJSON()
                let json = JSON(rawJson)
                let code = json[JsonKey.code.rawValue].stringValue
                if code == errorRefreshToken {
                    completion(false, response, true)
                } else if isSocialLogin && code == errorEmailIsAlreadyInCastcle {
                    completion(true, response, false)
                } else {
                    print("########## ERROR ##########")
                    print("\(response.request!)")
                    print("\(String(describing: response.request?.headers))")
                    print("\(json)")
                    print("###########################")
                    let errorMessage: String = json[JsonKey.message.rawValue].stringValue
                    let errorMessageArr: [String] = json[JsonKey.message.rawValue].arrayValue.map { $0.stringValue }
                    ApiHelper.displayError(code: "\(code)", error: "\(errorMessage.isEmpty ? errorMessageArr.joined(separator: "\n") : errorMessage)")
                    completion(false, response, false)
                }
            } catch {
                completion(false, response, false)
            }
        }
    }
}
