//
//  HomeNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/29.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/view/home

public struct HomeResponse: Decodable {
    public var viewState: ViewState
    public var challengeTotal: Int?
    public var onGoingChallenge: OnGoingChallenge?
    public var myInfo: User
    public var myCommit: Commit?
    public var partnerInfo: User
    public var partnerCommit: Commit?
    public var myStingCnt: Int?
    
    public enum ViewState: String, Decodable {
        case BEFORE_CREATE
        case BEFORE_MY_APPROVE
        case BEFORE_PARTNER_APPROVE
        case EXPIRED_BY_NOT_APPROVED
        case APPROVED_BUT_BEFORE_START_DATE
        case IN_PROGRESS
        case COMPLETE
    }
    
    public struct OnGoingChallenge: Decodable {
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
    
    public struct User: Decodable {
        public var userNo: Int
        public var nickname: String
        public var partnerNo: Int?
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

public protocol HomeNetworkWorkerProtocol {
    func requestHomeInquiry() async throws -> HomeResponse
}

public final class HomeNetworkWorker: HomeNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestHomeInquiry() async throws -> HomeResponse {
        return try await NetworkManager.shared.request(
            path: "/view/home",
            method: .get
        )
    }
}
