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
//  ReportApi.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 7/12/2564 BE.
//

import Core
import Moya

enum ReportApi {
    case getReportSubject
    case reportUser(String, ReportRequest)
    case reportContent(String, ReportRequest)
    case blockUser(String, ReportRequest)
    case unblockUser(String, String)
    case notAppealCast(String)
    case appealCast(String)
}

extension ReportApi: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseUrl)!
    }

    var path: String {
        switch self {
        case .getReportSubject:
            return APIs.Report.getReportSubject.path
        case .reportUser(let userId, _):
            return APIs.Report.reportUser(userId).path
        case .reportContent(let userId, _):
            return APIs.Report.reportContent(userId).path
        case .blockUser(let userId, _):
            return APIs.Report.blockUser(userId).path
        case .unblockUser(let userId, let targetCastcleId):
            return APIs.Report.unblockUser(userId, targetCastcleId).path
        case .notAppealCast(let contentId):
            return APIs.Report.notAppealCast(contentId).path
        case .appealCast(let contentId):
            return APIs.Report.appealCast(contentId).path
        }
    }

    var method: Moya.Method {
        switch self {
        case .getReportSubject:
            return .get
        case .reportUser, .reportContent, .blockUser, .notAppealCast, .appealCast:
            return .post
        case.unblockUser:
            return .delete
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case .reportUser(_, let reportRequest):
            return .requestParameters(parameters: reportRequest.paramReportUser, encoding: JSONEncoding.default)
        case .reportContent(_, let reportRequest):
            return .requestParameters(parameters: reportRequest.paramReportContent, encoding: JSONEncoding.default)
        case .blockUser(_, let reportRequest):
            return .requestParameters(parameters: reportRequest.paramBlockUser, encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ApiHelper.header()
    }
}
