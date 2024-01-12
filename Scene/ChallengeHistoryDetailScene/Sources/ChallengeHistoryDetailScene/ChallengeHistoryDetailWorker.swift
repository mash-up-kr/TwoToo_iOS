//
//  ChallengeHistoryDetailWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

protocol ChallengeHistoryDetailWorkerProtocol {
    /// 챌린지 상세 조회를 요청한다.
    func requestChallengeDetailInquiry(challengeID: String, commitID: Int) async throws -> ChallengeHistoryDetail.Model.ChallengeDetail
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
    
    func requestChallengeDetailInquiry(challengeID: String, commitID: Int) async throws -> ChallengeHistoryDetail.Model.ChallengeDetail {
        let challengeDetailListResponse = try await self.challengeDetailNetworkWorker.requestChallengeDetailInquiry(
            challengeNo: Int(challengeID) ?? 0
        )
        
        guard let data = (challengeDetailListResponse.user2CommitList + challengeDetailListResponse.user1CommitList).filter({ $0.commitNo == commitID }).first else {
            throw NSError(domain: "not exist detail history", code: -1)
        }
        
        let myNickname: String
        let partnerNickname: String
        let isMine = challengeDetailListResponse.user1CommitList.map(\.commitNo).contains(commitID)
        
        if isMine {
            myNickname = challengeDetailListResponse.user1.nickname
            partnerNickname = challengeDetailListResponse.user2.nickname
        } else {
            myNickname = challengeDetailListResponse.user2.nickname
            partnerNickname = challengeDetailListResponse.user1.nickname
        }
        
        return .init(
            challengeID: String(challengeDetailListResponse.challengeNo),
            id: String(data.commitNo),
            challengeName: challengeDetailListResponse.name,
            myNickname: myNickname,
            certificateImageUrl: data.photoUrl,
            certificateComment: data.text,
            certificateTime: data.createdAt.fullStringDate(.iso),
            partnerNickname: partnerNickname,
            complicateComment: data.partnerComment,
            isMine: isMine
        )
    }
}
