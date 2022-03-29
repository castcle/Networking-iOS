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
//  Metric.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 3/12/2564 BE.
//

import SwiftyJSON

// MARK: - Circle
public enum MetricKey: String, Codable {
    case likeCount
    case commentCount
    case quoteCount
    case recastCount
    case farmCount
}

public class Metric: NSObject {
    public var likeCount: Int = 0
    public var commentCount: Int = 0
    public var quoteCount: Int = 0
    public var recastCount: Int = 0
    public var farmCount: Int = 0
    
    public override init() {
        // MARK: - Init
    }
    
    public init(json: JSON) {
        self.likeCount = json[MetricKey.likeCount.rawValue].intValue
        self.commentCount = json[MetricKey.commentCount.rawValue].intValue
        self.quoteCount = json[MetricKey.quoteCount.rawValue].intValue
        self.recastCount = json[MetricKey.recastCount.rawValue].intValue
        self.farmCount = json[MetricKey.farmCount.rawValue].intValue
    }
}
