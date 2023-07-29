//
//  AuthNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/23.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/user/authorize

public struct AuthResponse: Decodable {
    public var userNo: Int
    public var nickname: String?
    public var partnerNo: Int?
    public var socialId: String
    public var loginType: String
    public var deviceToken: String
    public var state: String
    public var accessToken: String
}

public protocol AuthNetworkWorkerProtocol {
    func requestAuthorize(socialId: String, loginType: String, deviceToken: String) async throws -> AuthResponse
}

public final class AuthNetworkWorker: AuthNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestAuthorize(socialId: String, loginType: String, deviceToken: String) async throws -> AuthResponse {
        return try await NetworkManager.shared.request(
            path: "/user/authorize",
            method: .post,
            parameters: [
                "socialId": socialId,
                "loginType": loginType,
                "deviceToken": deviceToken
            ]
        )
    }
}
