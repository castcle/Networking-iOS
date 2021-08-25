//
//  Provider.swift
//  Networking
//
//  Created by Tanakorn Phoochaliaw on 23/8/2564 BE.
//

import Moya

extension MoyaProvider {
//    convenience init(handleRefreshToken: Bool) {
//        if handleRefreshToken {
//            self.init(requestClosure: MoyaProvider.endpointResolver())
//        } else {
//            self.init()
//        }
//    }
//    
//    static func endpointResolver() -> MoyaProvider<Target>.RequestClosure {
//        return { (endpoint, closure) in
//            //Getting the original request
//            let request = try! endpoint.urlRequest()
//            
//            //assume you have saved the existing token somewhere
//            if (#tokenIsNotExpired#) {
//                // Token is valid, so just resume the original request
//                closure(.success(request))
//                return
//            }
//            
//            //Do a request to refresh the authtoken based on refreshToken
//            let authenticationApi = MoyaProvider<AuthenticationApi>()
//            authenticationApi.request(.refreshToken) { result in
//                switch result {
//                case .success(let response):
//                    let token = response.mapJSON()["token"]
//                    let newRefreshToken = response.mapJSON()["refreshToken"]
//                    //overwrite your old token with the new token
//                    //overwrite your old refreshToken with the new refresh token
//                    
//                    closure(.success(request)) // This line will "resume" the actual request, and then you can use AccessTokenPlugin to set the Authentication header
//                case .failure(let error):
//                    closure(.failure(error)) //something went terrible wrong! Request will not be performed
//                }
//            }
//        }
//    }
}
