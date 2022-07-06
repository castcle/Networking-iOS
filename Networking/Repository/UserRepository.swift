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
//  UserRepository.swift
//  Networking
//
//  Created by Castcle Co., Ltd. on 13/9/2564 BE.
//

import Core
import Moya
import SwiftyJSON

public protocol UserRepository {
    func getMe(_ completion: @escaping ResponseHandle)
    func updateInfo(userId: String, userRequest: UserRequest, _ completion: @escaping ResponseHandle)
    func updateAvatar(userId: String, userRequest: UserRequest, _ completion: @escaping ResponseHandle)
    func updateCover(userId: String, userRequest: UserRequest, _ completion: @escaping ResponseHandle)
    func updateMobile(userRequest: UserRequest, _ completion: @escaping ResponseHandle)
    func delateUser(userRequest: UserRequest, _ completion: @escaping ResponseHandle)
    func getUser(userId: String, _ completion: @escaping ResponseHandle)
    func getUserContents(userId: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle)
    func getUserFollower(userId: String, userFollowRequest: UserFollowRequest, _ completion: @escaping ResponseHandle)
    func getUserFollowing(userId: String, userFollowRequest: UserFollowRequest, _ completion: @escaping ResponseHandle)
    func follow(userRequest: UserRequest, _ completion: @escaping ResponseHandle)
    func unfollow(targetCastcleId: String, _ completion: @escaping ResponseHandle)
    func syncSocial(userId: String, pageSocial: PageSocial, _ completion: @escaping ResponseHandle)
    func pdpa(date: String, _ completion: @escaping ResponseHandle)
}

public final class UserRepositoryImpl: UserRepository {
    private let userProvider = MoyaProvider<UserApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()

    public init() {
        // MARK: - Init
    }

    public func getMe(_ completion: @escaping ResponseHandle) {
        self.userProvider.request(.getMe) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func updateInfo(userId: String, userRequest: UserRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.updateInfo(userId, userRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func updateAvatar(userId: String, userRequest: UserRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.updateAvatar(userId, userRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func updateCover(userId: String, userRequest: UserRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.updateCover(userId, userRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func updateMobile(userRequest: UserRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.updateMobile(userRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func delateUser(userRequest: UserRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.delateUser(userRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func getUser(userId: String, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.getUser(userId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func getUserContents(userId: String, contentRequest: ContentRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.getUserContents(userId, contentRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func getUserFollower(userId: String, userFollowRequest: UserFollowRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.getUserFollower(userId, userFollowRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func getUserFollowing(userId: String, userFollowRequest: UserFollowRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.getUserFollowing(userId, userFollowRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func follow(userRequest: UserRequest, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.follow(userRequest)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func unfollow(targetCastcleId: String, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.unfollow(targetCastcleId)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func syncSocial(userId: String, pageSocial: PageSocial, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.syncSocial(userId, pageSocial)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }

    public func pdpa(date: String, _ completion: @escaping ResponseHandle) {
        self.userProvider.request(.pdpa(date)) { result in
            switch result {
            case .success(let response):
                self.completionHelper.handleNetworingResponse(response: response) { (success, response, isRefreshToken) in
                    completion(success, response, isRefreshToken)
                }
            case .failure:
                completion(false, Response(statusCode: 500, data: ApiHelper.errorResponse), false)
            }
        }
    }
}
