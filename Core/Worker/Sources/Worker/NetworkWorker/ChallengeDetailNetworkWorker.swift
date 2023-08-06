//
//  ChallengeDetailNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/30.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/challenge/0

public struct ChallengeDetailResponse: Decodable {
    public var challengeNo: Int
    public var name: String
    public var description: String
    public var user1: User
    public var user2: User
    public var startDate: String
    public var endDate: String
    public var user1CommitCnt: Int
    public var user2CommitCnt: Int
    public var user1Flower: Flower
    public var user2Flower: Flower
    public var isApproved: Bool
    public var isFinished: Bool
    public var user1CommitList: [Commit]
    public var user2CommitList: [Commit]
    
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
    
    public struct Commit: Decodable {
        public var commitNo: Int
        public var userNo: Int
        public var challengeNo: Int
        public var text: String
        public var photoUrl: String
        public var partnerComment: String?
        public var createdAt: String
        public var updatedAt: String
    }
}

public protocol ChallengeDetailNetworkWorkerProtocol {
    func requestChallengeDetailInquiry(challengeNo: Int) async throws -> ChallengeDetailResponse
}

public final class ChallengeDetailNetworkWorker: ChallengeDetailNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestChallengeDetailInquiry(challengeNo: Int) async throws -> ChallengeDetailResponse {
        return try await NetworkManager.shared.request(
            path: "/challenge/\(challengeNo)",
            method: .get
        )
    }
}
