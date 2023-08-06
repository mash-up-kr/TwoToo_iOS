//
//  ChallengeQuitNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/08/01.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/challenge/0

public struct ChallengeQuitResponse: Decodable {
    
}

public protocol ChallengeQuitNetworkWorkerProtocol {
    func requestChallengeQuit(challengeNo: Int) async throws -> ChallengeQuitResponse
}

public final class ChallengeQuitNetworkWorker: ChallengeQuitNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestChallengeQuit(challengeNo: Int) async throws -> ChallengeQuitResponse {
        return try await NetworkManager.shared.request(
            path: "/challenge/\(challengeNo)",
            method: .delete
        )
    }
}
