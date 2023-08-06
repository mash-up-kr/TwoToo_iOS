//
//  HistoryNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/08/01.
//

import Foundation
import Network

// https://https://twotoo-node-zmtrd.run.goorm.site/challenge/histories

public struct HistoryResponse: Decodable {
    public var challengeNo: Int
    public var name: String
    public var description: String
    public var startDate: String
    public var endDate: String
    public var user1CommitCnt: Int
    public var user2CommitCnt: Int
    public var user1Flower: Flower
    public var user2Flower: Flower
    public var user1No: Int
    public var user2No: Int
    
    public enum Flower: String, Decodable {
        case FIG
        case TULIP
        case ROSE
        case COTTON
        case CHRYSANTHEMUM
        case SUNFLOWER
        case CAMELLIA
        case DELPHINIUM
        
        case none = ""
    }
}

public protocol HistoryNetworkWorkerProtocol {
    func requestHistoryInquiry() async throws -> [HistoryResponse]
}

public final class HistoryNetworkWorker: HistoryNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestHistoryInquiry() async throws -> [HistoryResponse] {
//        return [
//            .init(challengeNo: 0, name: "fdafdas", description: "fdafdasfas", startDate: "2023-08-01T03:23:27.788Z", endDate: "2023-08-24T03:23:27.788Z", user1CommitCnt: 14, user2CommitCnt: 20, user1Flower: .CAMELLIA, user2Flower: .CHRYSANTHEMUM),
//            .init(challengeNo: 1, name: "fdafdas", description: "fdafdasfas", startDate: "2023-08-01T03:23:27.788Z", endDate: "2023-08-24T03:23:27.788Z", user1CommitCnt: 0, user2CommitCnt: 10, user1Flower: .DELPHINIUM, user2Flower: .FIG),
//            .init(challengeNo: 2, name: "fdafdas", description: "fdafdasfas", startDate: "2023-08-01T03:23:27.788Z", endDate: "2023-08-24T03:23:27.788Z", user1CommitCnt: 3, user2CommitCnt: 22, user1Flower: .CAMELLIA, user2Flower: .DELPHINIUM),
//            .init(challengeNo: 3, name: "fdafdas", description: "fdafdasfas", startDate: "2023-08-01T03:23:27.788Z", endDate: "2023-08-24T03:23:27.788Z", user1CommitCnt: 4, user2CommitCnt: 1, user1Flower: .COTTON, user2Flower: .ROSE)
//        ]
//
        return try await NetworkManager.shared.request(
            path: "/challenge/histories",
            method: .get
        )
    }
}
