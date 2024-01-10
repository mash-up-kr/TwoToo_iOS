//
//  ChallengeHistoryDetailWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import CoreKit

protocol ChallengeHistoryDetailWorkerProtocol {
    /// 챌린지 상세 조회를 요청한다.
    func requestChallengeDetailInquiry(challengeID: String) async throws -> ChallengeHistoryDetail.Model.ChallengeDetail
}

final class ChallengeHistoryDetailWorker: ChallengeHistoryDetailWorkerProtocol {
    var meLocalWorker: MeLocalWorkerProtocol
    var challengeDetailNetworkWorker: ChallengeDetailNetworkWorkerProtocol

    init(
        meLocalWorker: MeLocalWorkerProtocol,
        challengeDetailNetworkWorker: ChallengeDetailNetworkWorkerProtocol
    ) {
        self.meLocalWorker = meLocalWorker
        self.challengeDetailNetworkWorker = challengeDetailNetworkWorker
    }

    func requestChallengeDetailInquiry(challengeID: String) async throws -> ChallengeHistoryDetail.Model.ChallengeDetail {
        let challengeDetailResponse = try await self.challengeDetailNetworkWorker.requestChallengeDetailInquiry(
            challengeNo: Int(challengeID) ?? 0
        )

        if let list = challengeDetailResponse.user2CommitList {
            
        }
    }
}
