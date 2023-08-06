//
//  MeNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/29.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/user/me

public struct MeResponse: Decodable {
    public var userNo: Int
    public var nickname: String?
    public var partnerNo: Int?
    public var partnerNickname: String?
    public var totalChallengeCount: Int?
}

public protocol MeNetworkWorkerProtocol {
    func requestMeInquiry() async throws -> MeResponse
}

public final class MeNetworkWorker: MeNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestMeInquiry() async throws -> MeResponse {
        return try await NetworkManager.shared.request(
            path: "/user/me",
            method: .get
        )
    }
}
