//
//  ChallengeApproveNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/08/02.
//

import Foundation
import Network

// https://https://twotoo-node-zmtrd.run.goorm.site/challenge/0/approve

public struct ChallengeApproveResponse: Decodable {
    let challengeNo: Int
    let name, description: String
    let user1, user2: User
    let startDate, endDate: String
    let user1CommitCnt, user2CommitCnt: Int
    let user1Flower, user2Flower: String
    let isApproved, isFinished: Bool
    
    public struct User: Decodable {
        let userNo: Int
        let nickname: String
        let partnerNo: Int
    }
}

public protocol ChallengeApproveNetworkWorkerProtocol {
    func requestChallengeApprove(challengeNo: Int, user1Flower: String) async throws -> ChallengeApproveResponse
}

public final class ChallengeApproveNetworkWorker: ChallengeApproveNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestChallengeApprove(challengeNo: Int, user1Flower: String) async throws -> ChallengeApproveResponse {
        return try await NetworkManager.shared.request(
            path: "/challenge/\(challengeNo)/approve",
            method: .post,
            parameters: [
                "user1Flower": user1Flower
            ]
        )
    }
}
