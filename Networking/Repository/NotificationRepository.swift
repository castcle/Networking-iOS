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
//  NotificationRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 23/9/2564 BE.
//

import Core
import Moya
import SwiftyJSON
import Defaults

public protocol NotificationRepository {
    func registerToken(notificationRequest: NotificationRequest, _ completion: @escaping complate)
    func unregisterToken(notificationRequest: NotificationRequest, _ completion: @escaping complate)
    func getBadges(_ completion: @escaping complate)
    func getNotification(notificationRequest: NotificationRequest, _ completion: @escaping complate)
    func deleteNotification(notifyId: String, _ completion: @escaping complate)
    func readNotification(notifyId: String, _ completion: @escaping complate)
}

public final class NotificationRepositoryImpl: NotificationRepository {
    private let notificationProvider = MoyaProvider<NotificationApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()
    
    public init() {
        // MARK: - Init
    }
    
    public func registerToken(notificationRequest: NotificationRequest, _ completion: @escaping complate) {
        self.notificationProvider.request(.registerToken(notificationRequest)) { result in
            switch result {
            case .success(let response):
                completion(true, response, false)
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func unregisterToken(notificationRequest: NotificationRequest, _ completion: @escaping complate) {
        self.notificationProvider.request(.unregisterToken(notificationRequest)) { result in
            switch result {
            case .success(let response):
                completion(true, response, false)
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func getBadges(_ completion: @escaping complate) {
        self.notificationProvider.request(.getBadges) { result in
            switch result {
            case .success(let response):
                do {
                    let rawJson = try response.mapJSON()
                    let json = JSON(rawJson)
                    Defaults[.badgePage] = json[JsonKey.page.rawValue].intValue
                    Defaults[.badgeProfile] = json[JsonKey.profile.rawValue].intValue
                    Defaults[.badgeSystem] = json[JsonKey.system.rawValue].intValue
                    self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                        completion(success, response, isRefreshToken)
                    }
                } catch {
                    completion(false, response, false)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func getNotification(notificationRequest: NotificationRequest, _ completion: @escaping complate) {
        self.notificationProvider.request(.getNotification(notificationRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func deleteNotification(notifyId: String, _ completion: @escaping complate) {
        self.notificationProvider.request(.deleteNotification(notifyId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func readNotification(notifyId: String, _ completion: @escaping complate) {
        self.notificationProvider.request(.readNotification(notifyId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
}
