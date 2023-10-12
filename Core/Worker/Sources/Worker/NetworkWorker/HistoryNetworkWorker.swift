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
    public var viewState: String
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
        return try await NetworkManager.shared.request(
            path: "/challenge/histories",
            method: .get
        )
    }
}
