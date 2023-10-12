//
//  SignOutNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/10/02.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/user/signOut

public struct SignOutResponse: Decodable {
    
}

public protocol SignOutNetworkWorkerProtocol {
    func requestSignOut() async throws -> SignOutResponse
}

public final class SignOutNetworkWorker: SignOutNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestSignOut() async throws -> SignOutResponse {
        return try await NetworkManager.shared.request(
            path: "/user/signOut/",
            method: .delete
        )
    }
}
