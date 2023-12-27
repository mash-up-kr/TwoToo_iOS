//
//  ChallengeHistoryWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

protocol ChallengeHistoryWorkerProtocol {
    /// 챌린지 상세 조회를 요청한다.
    func requestChallengeDetailInquiry(challengeID: String) async throws -> ChallengeHistory.Model.Challenge
    /// 챌린지 그만두기 요청을 한다.
    func requestChallengeQuit(challengeID: String) async throws
    
    /// 내 닉네임
    var myNickname: String? { get }
    /// 파트너 닉네임
    var partnerNickname: String? { get }
}

final class ChallengeHistoryWorker: ChallengeHistoryWorkerProtocol {
    
    var meLocalWorker: MeLocalWorkerProtocol
    var challengeDetailNetworkWorker: ChallengeDetailNetworkWorkerProtocol
    var challengeQuitNetworkWorker: ChallengeQuitNetworkWorkerProtocol
    
    init(
        meLocalWorker: MeLocalWorkerProtocol,
        challengeDetailNetworkWorker: ChallengeDetailNetworkWorkerProtocol,
        challengeQuitNetworkWorker: ChallengeQuitNetworkWorkerProtocol
    ) {
        self.meLocalWorker = meLocalWorker
        self.challengeDetailNetworkWorker = challengeDetailNetworkWorker
        self.challengeQuitNetworkWorker = challengeQuitNetworkWorker
    }
    
    func requestChallengeDetailInquiry(challengeID: String) async throws -> ChallengeHistory.Model.Challenge {
        let challengeDetailResponse = try await self.challengeDetailNetworkWorker.requestChallengeDetailInquiry(
            challengeNo: Int(challengeID) ?? 0
        )
        
        var myInfo: ChallengeHistory.Model.User
        var partnerInfo: ChallengeHistory.Model.User
        
        if challengeDetailResponse.user1.userNo == self.meLocalWorker.userNo {
            myInfo = mapUserInfo(
                from: challengeDetailResponse.user1,
                commitList: challengeDetailResponse.user1CommitList,
                commitCount: challengeDetailResponse.user1CommitCnt
            )
            partnerInfo = mapUserInfo(
                from: challengeDetailResponse.user2,
                commitList: challengeDetailResponse.user2CommitList,
                commitCount: challengeDetailResponse.user2CommitCnt
            )
        }
        else {
            myInfo = mapUserInfo(
                from: challengeDetailResponse.user2,
                commitList: challengeDetailResponse.user2CommitList,
                commitCount: challengeDetailResponse.user2CommitCnt
            )
            partnerInfo = mapUserInfo(
                from: challengeDetailResponse.user1,
                commitList: challengeDetailResponse.user1CommitList,
                commitCount: challengeDetailResponse.user1CommitCnt
            )
        }
        
        let startDate = challengeDetailResponse.startDate.fullStringDate(.iso)
        let endDate = challengeDetailResponse.endDate.fullStringDate(.iso)
        
        return .init(
            id: String(challengeDetailResponse.challengeNo),
            name: challengeDetailResponse.name,
            additionalInfo: challengeDetailResponse.description,
            startDate: startDate,
            endDate: endDate,
            myInfo: myInfo,
            partnerInfo: partnerInfo,
            isFinished: challengeDetailResponse.isFinished
        )
    }
    
    func requestChallengeQuit(challengeID: String) async throws {
        _ = try await self.challengeQuitNetworkWorker.requestChallengeQuit(challengeNo: Int(challengeID) ?? 0)
    }
    
    var myNickname: String? {
        return self.meLocalWorker.nickname
    }
    
    var partnerNickname: String? {
        return self.meLocalWorker.partnerNickname
    }
    
    private func mapUserInfo(from user: ChallengeDetailResponse.User, 
                             commitList: [ChallengeDetailResponse.Commit]?,
                             commitCount: Int?) 
    -> ChallengeHistory.Model.User 
    {
        var certificates: [ChallengeHistory.Model.Certificate] = []
        if let commitList = commitList {
            certificates = commitList.map {
                return .init(
                    id: String($0.commitNo),
                    certificateImageUrl: $0.photoUrl,
                    certificateComment: $0.text,
                    certificateTime: $0.createdAt.fullStringDate(.iso),
                    complimentComment: $0.partnerComment
                )
            }
        }
        
        let userInfo: ChallengeHistory.Model.User = .init(
            id: String(user.userNo),
            nickname: user.nickname,
            certCount: commitCount,
            certificates: certificates
        )
        
        return userInfo
    }
}
