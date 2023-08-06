//
//  HistoryWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol HistoryWorkerProtocol {
    func fetchChallengeList() async throws -> History.Model.ChallengeList
}

final class HistoryWorker: HistoryWorkerProtocol {
    
    var meLocalWorker: MeLocalWorkerProtocol
    var historyNetworkWorker: HistoryNetworkWorkerProtocol
    
    init(
        meLocalWorker: MeLocalWorkerProtocol,
        historyNetworkWorker: HistoryNetworkWorkerProtocol
    ) {
        self.meLocalWorker = meLocalWorker
        self.historyNetworkWorker = historyNetworkWorker
    }
    
    func fetchChallengeList() async throws -> History.Model.ChallengeList {
        let historyResponse = try await self.historyNetworkWorker.requestHistoryInquiry()
        
        if historyResponse.first?.user1No == self.meLocalWorker.userNo {
            return historyResponse.enumerated().map({ index, history in
                return .init(
                    id: String(history.challengeNo),
                    order: index + 1,
                    name: history.name,
                    startDate: history.startDate.fullStringDate(.iso),
                    endDate: history.endDate.fullStringDate(.iso),
                    myFlower: history.user1CommitCnt < 17 ? nil : self.mapFlowerType(from: history.user1Flower),
                    partnerFlower: history.user2CommitCnt < 17 ? nil : self.mapFlowerType(from: history.user2Flower)
                )
            }).reversed()
        }
        else {
            return historyResponse.enumerated().map({ index, history in
                return .init(
                    id: String(history.challengeNo),
                    order: index + 1,
                    name: history.name,
                    startDate: history.startDate.fullStringDate(.iso),
                    endDate: history.endDate.fullStringDate(.iso),
                    myFlower: history.user2CommitCnt < 17 ? nil : self.mapFlowerType(from: history.user2Flower),
                    partnerFlower: history.user1CommitCnt < 17 ? nil : self.mapFlowerType(from: history.user1Flower)
                )
            }).reversed()
        }
    }
    
    private func mapFlowerType(from flower: HistoryResponse.Flower) -> Flower? {
        switch flower {
            case .FIG:
                return .fig
                
            case .TULIP:
                return .tulip
                
            case .ROSE:
                return .rose
                
            case .COTTON:
                return .cotton
                
            case .CHRYSANTHEMUM:
                return .chrysanthemum
                
            case .SUNFLOWER:
                return .sunflower
                
            case .CAMELLIA:
                return .camellia
                
            case .DELPHINIUM:
                return .delphinium
                
            case .none:
                return nil
        }
    }
}
