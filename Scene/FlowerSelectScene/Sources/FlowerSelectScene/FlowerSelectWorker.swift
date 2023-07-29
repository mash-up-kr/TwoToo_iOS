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
}

final class FlowerSelectWorker: FlowerSelectWorkerProtocol {

    var challengeCrateNetworkWorker: ChallengeCreateNetworkWorkerProtocol

    init(
        challengeCrateNetworkWorker: ChallengeCreateNetworkWorkerProtocol
    ) {
        self.challengeCrateNetworkWorker = challengeCrateNetworkWorker
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
}
