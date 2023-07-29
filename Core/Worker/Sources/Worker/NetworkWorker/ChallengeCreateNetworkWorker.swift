//
//  ChallengeCreateNetworkWorker.swift
//  
//
//  Created by Eddy on 2023/07/29.
//

import Foundation
import Network

// https://https://twotoo-node-zmtrd.run.goorm.site/challenge

public struct ChallengeCreateResponse: Decodable {
    let challengeNo: Int
    let name, description: String
    let user1, user2: User
    let startDate, endDate: String
    let user1CommitCnt, user2CommitCnt: Int
    let user1Flower, user2Flower: String
    let isApproved, isFinished: Bool
}

public struct User: Decodable {
    let userNo: Int
    let nickname: String
    let partnerNo: Int
}

public protocol ChallengeCreateNetworkWorkerProtocol {
    func requestChallengeRegist(name: String, description: String, user2Flower: String, startDate: String) async throws -> ChallengeCreateResponse
}

public final class FlowerSelectNetworkWorker: ChallengeCreateNetworkWorkerProtocol {

    public init() {}
    
    public func requestChallengeRegist(name: String, description: String, user2Flower: String, startDate: String) async throws -> ChallengeCreateResponse {
        return try await NetworkManager.shared.request(
            path: "/challenge",
            method: .post,
            parameters: [
                "name": name,
                "description": description,
                "user2Flower": user2Flower.uppercased(),
                "startDate": startDate
            ]
        )
    }
}
