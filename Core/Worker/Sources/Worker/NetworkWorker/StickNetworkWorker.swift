//
//  StickNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/29.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/notification/sting

public struct StickResponse: Decodable {
    public var userNo: Int
    public var message: String
}

public protocol StickNetworkWorkerProtocol {
    func requestStick(message: String) async throws -> StickResponse
}

public final class StickNetworkWorker: StickNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestStick(message: String) async throws -> StickResponse {
        return try await NetworkManager.shared.request(
            path: "/notification/sting",
            method: .post,
            parameters: [
                "message": message
            ]
        )
    }
}
