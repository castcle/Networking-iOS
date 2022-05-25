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
//  NotificationApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 23/9/2564 BE.
//

import Core
import Moya

enum NotificationApi {
    case registerToken(NotificationRequest)
    case unregisterToken(NotificationRequest)
    case getBadges
    case getNotification(NotificationRequest)
    case deleteNotification(String)
    case readNotification(String)
    case readAllNotification(NotificationRequest)
}

extension NotificationApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .registerToken:
            return APIs.Notification.registerToken.path
        case .unregisterToken:
            return  APIs.Notification.unregisterToken.path
        case .getBadges:
            return  APIs.Notification.getBadges.path
        case .getNotification:
            return  APIs.Notification.getNotification.path
        case .deleteNotification(let notifyId):
            return  APIs.Notification.deleteNotification(notifyId).path
        case .readNotification(let notifyId):
            return  APIs.Notification.readNotification(notifyId).path
        case.readAllNotification:
            return  APIs.Notification.readAllNotification.path
        }
    }

    var method: Moya.Method {
        switch self {
        case .registerToken, .readNotification, .readAllNotification:
            return .post
        case .unregisterToken, .deleteNotification:
            return .delete
        case .getBadges, .getNotification:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .registerToken(let notificationRequest):
            return .requestParameters(parameters: notificationRequest.paramRegisterToken, encoding: JSONEncoding.default)
        case .unregisterToken(let notificationRequest):
            return .requestParameters(parameters: notificationRequest.paramRegisterToken, encoding: JSONEncoding.default)
        case .getNotification(let notificationRequest):
            return .requestParameters(parameters: notificationRequest.paramGetNotifications, encoding: URLEncoding.queryString)
        case .readAllNotification(let notificationRequest):
            return .requestParameters(parameters: notificationRequest.paramReadAllNotifications, encoding: URLEncoding.queryString)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        case .getBadges, .getNotification, .deleteNotification, .readNotification, .readAllNotification:
            return ApiHelper.header()
        default:
            return ApiHelper.header(version: "1.0")
        }
    }
}
