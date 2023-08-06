//
//  FlowerSelectWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol FlowerSelectWorkerProtocol {
    func requestChallengeCreate(name: String, description: String, user2Flower: String, startDate: String) async throws
    func requestChallengeApprove(challengeID: String, user1Flower: String) async throws
}

final class FlowerSelectWorker: FlowerSelectWorkerProtocol {

    var challengeCrateNetworkWorker: ChallengeCreateNetworkWorkerProtocol
    var challengeApproveNetworkWorker: ChallengeApproveNetworkWorkerProtocol

    init(
        challengeCrateNetworkWorker: ChallengeCreateNetworkWorkerProtocol,
        challengeApproveNetworkWorker: ChallengeApproveNetworkWorkerProtocol
    ) {
        self.challengeCrateNetworkWorker = challengeCrateNetworkWorker
        self.challengeApproveNetworkWorker = challengeApproveNetworkWorker
    }

    func requestChallengeCreate(
        name: String,
        description: String,
        user2Flower: String,
        startDate: String
    ) async throws {
        let challengeCrateResponse = try await self.challengeCrateNetworkWorker.requestChallengeRegist(
            name: name,
            description: description,
            user2Flower: user2Flower,
            startDate: startDate
        )

        print(challengeCrateResponse)
    }
    
    func requestChallengeApprove(challengeID: String, user1Flower: String) async throws {
        _ = try await self.challengeApproveNetworkWorker.requestChallengeApprove(
            challengeNo: Int(challengeID) ?? 0,
            user1Flower: user1Flower
        )
    }
}
