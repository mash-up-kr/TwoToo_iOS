//
//  ChallengeConfirmWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeConfirmWorkerProtocol {
    /// 챌린지 그만두기 요청을 한다.
    func requestChallengeQuit(challengeID: String) async throws
}

final class ChallengeConfirmWorker: ChallengeConfirmWorkerProtocol {
    var challengeQuitNetworkWorker: ChallengeQuitNetworkWorkerProtocol
    
    init(
        challengeQuitNetworkWorker: ChallengeQuitNetworkWorkerProtocol
    ) {
        self.challengeQuitNetworkWorker = challengeQuitNetworkWorker
    }

    func requestChallengeQuit(challengeID: String) async throws {
        _ = try await self.challengeQuitNetworkWorker.requestChallengeQuit(challengeNo: Int(challengeID) ?? 0)
    }
}
