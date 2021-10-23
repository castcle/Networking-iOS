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
    func updateMe(userRequest: UserRequest, _ completion: @escaping complate)
    func updateMeAvatar(userRequest: UserRequest, _ completion: @escaping complate)
    func updateMeCover(userRequest: UserRequest, _ completion: @escaping complate)
    func delateUser(userRequest: UserRequest, _ completion: @escaping complate)
    func getUser(userId: String, _ completion: @escaping complate)
    func getUserContents(userId: String, _ completion: @escaping complate)
    func getUserFollower(userId: String, _ completion: @escaping complate)
    func getUserFollowing(userId: String, _ completion: @escaping complate)
    func follow(userId: String, _ completion: @escaping complate)
    func unfollow(userId: String, _ completion: @escaping complate)
}

public final class UserRepositoryImpl: UserRepository {
    private let userProvider = MoyaProvider<UserApi>()
    
    public init() {
        // MARK: - Init
    }
    
    public func getAllUser(_ completion: @escaping complate) {
        self.userProvider.request(.getAllUser) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
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
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func updateMe(userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.updateMe(userRequest)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func updateMeAvatar(userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.updateMeAvatar(userRequest)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func updateMeCover(userRequest: UserRequest, _ completion: @escaping complate) {
        self.userProvider.request(.updateMeCover(userRequest)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
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
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
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
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func getUserContents(userId: String, _ completion: @escaping complate) {
        self.userProvider.request(.getUserContents(userId)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
    
    public func getUserFollower(userId: String, _ completion: @escaping complate) {
        self.userProvider.request(.getUserFollower(userId)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }

    public func getUserFollowing(userId: String, _ completion: @escaping complate) {
        self.userProvider.request(.getUserFollowing(userId)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }

    public func follow(userId: String, _ completion: @escaping complate) {
        self.userProvider.request(.follow(userId)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }

    public func unfollow(userId: String, _ completion: @escaping complate) {
        self.userProvider.request(.unfollow(userId)) { result in
            switch result {
            case .success(let response):
                if response.statusCode < 300 {
                    completion(true, response, false)
                } else {
                    do {
                        let rawJson = try response.mapJSON()
                        let json = JSON(rawJson)
                        let code = json[ResponseErrorKey.code.rawValue].stringValue
                        if code == errorRefreshToken {
                            completion(false, response, true)
                        } else {
                            ApiHelper.displayError(error: "\(code) : \(json[ResponseErrorKey.message.rawValue].stringValue)")
                            completion(false, response, false)
                        }
                    } catch {
                        completion(false, response, false)
                    }
                }
            case .failure(let error):
                completion(false, error as! Response, false)
            }
        }
    }
}
