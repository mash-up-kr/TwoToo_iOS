//
//  ChallengeFinishNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/29.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/challenge/0/finish

public struct ChallengeFinishResponse: Decodable {
    public var challengeNo: Int?
    public var name: String?
    public var description: String?
    public var user1: User?
    public var user2: User?
    public var startDate: String?
    public var endDate: String?
    public var user1CommitCnt: Int?
    public var user2CommitCnt: Int?
    public var user1Flower: Flower?
    public var user2Flower: Flower?
    public var isApproved: Bool?
    public var isFinished: Bool?
    
    public struct User: Decodable {
        public var userNo: Int
        public var nickname: String
        public var partnerNo: Int
    }
    
    public enum Flower: String, Decodable {
        case FIG
        case TULIP
        case ROSE
        case COTTON
        case CHRYSANTHEMUM
        case SUNFLOWER
        case CAMELLIA
        case DELPHINIUM
    }
}

public protocol ChallengeFinishNetworkWorkerProtocol {
    func requestChallengeFinish(challengeNo: Int) async throws -> ChallengeFinishResponse
}

public final class ChallengeFinishNetworkWorker: ChallengeFinishNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestChallengeFinish(challengeNo: Int) async throws -> ChallengeFinishResponse {
        return try await NetworkManager.shared.request(
            path: "/challenge/\(challengeNo)/finish",
            method: .post
        )
    }
}
