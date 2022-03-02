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
    func getAllUser(_ completion: @escaping complate)
    func getMe(_ completion: @escaping complate)
    func updateInfo(userId: String, userRequest: UserRequest, _ completion: @escaping complate)
    func updateAvatar(userId: String, userRequest: UserRequest, _ completion: @escaping complate)
    func updateCover(userId: String, userRequest: UserRequest, _ completion: @escaping complate)
    func updateMobile(userRequest: UserRequest, _ completion: @escaping complate)
    func delateUser(userRequest: UserRequest, _ completion: @escaping complate)
    func getUser(userId: String, _ completion: @escaping complate)
    func getUserContents(userId: String, contentRequest: ContentRequest, _ completion: @escaping complate)
    func getUserFollower(userId: String, userFollowRequest: UserFollowRequest, _ completion: @escaping complate)
    func getUserFollowing(userId: String, userFollowRequest: UserFollowRequest, _ completion: @escaping complate)
    func follow(userId: String, userRequest: UserRequest, _ completion: @escaping complate)
    func unfollow(userId: String, targetCastcleId: String, _ completion: @escaping complate)
}

public final class UserRepositoryImpl: UserRepository {
    private let userProvider = MoyaProvider<UserApi>()
    private let completionHelper: CompletionHelper = CompletionHelper()
    
    public init() {
        // MARK: - Init
    }
    
    public func getAllUser(_ completion: @escaping complate) {
        self.userProvider.request(.getAllUser) { result in
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
    
    public func getMe(_ completion: @escaping complate) {
        self.userProvider.request(.getMe) { result in
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
    
    public func updateInfo(userId: String, userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.updateInfo(userId, userRequest)) { result in
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
    
    public func updateAvatar(userId: String, userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.updateAvatar(userId, userRequest)) { result in
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
    
    public func updateCover(userId: String, userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.updateCover(userId, userRequest)) { result in
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
    
    public func updateMobile(userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.updateMobile(userRequest)) { result in
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
    
    public func delateUser(userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.delateUser(userRequest)) { result in
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
    
    public func getUser(userId: String, _ completion: @escaping complate) {
        self.userProvider.request(.getUser(userId)) { result in
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
    
    public func getUserContents(userId: String, contentRequest: ContentRequest, _ completion: @escaping complate) {
        self.userProvider.request(.getUserContents(userId, contentRequest)) { result in
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
    
    public func getUserFollower(userId: String, userFollowRequest: UserFollowRequest, _ completion: @escaping complate) {
        self.userProvider.request(.getUserFollower(userId, userFollowRequest)) { result in
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

    public func getUserFollowing(userId: String, userFollowRequest: UserFollowRequest, _ completion: @escaping complate) {
        self.userProvider.request(.getUserFollowing(userId, userFollowRequest)) { result in
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

    public func follow(userId: String, userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.follow(userId, userRequest)) { result in
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

    public func unfollow(userId: String, targetCastcleId: String, _ completion: @escaping complate) {
        self.userProvider.request(.unfollow(userId, targetCastcleId)) { result in
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
