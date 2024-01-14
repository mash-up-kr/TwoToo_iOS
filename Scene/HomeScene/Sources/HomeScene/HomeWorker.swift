//
//  HomeWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import Foundation
import CoreKit

protocol HomeWorkerProtocol {
    /// 챌린지 완료 확인 여부
    var challengeCompletedConfirmed: Bool { get set }
    /// 둘다 인증 확인 여부
    var bothCertificationConfirmed: Bool { get set }
    /// 홈 조회
    func fetchHomeInfo() async throws -> Home.Model.HomeInfo
    /// 챌린지 완료 요청
    func requestChallengeComplete(challengeID: String) async throws
}

final class HomeWorker: HomeWorkerProtocol {
    
    var homeLocalWorker: HomeLocalWorkerProtocol
    var meLocalWorker: MeLocalWorkerProtocol
    var homeNetworkWorker: HomeNetworkWorkerProtocol
    var challengeFinishNetworkWorker: ChallengeFinishNetworkWorkerProtocol
    
    init(
        homeLocalWorker: HomeLocalWorkerProtocol,
        meLocalWorker: MeLocalWorkerProtocol,
        homeNetworkWorker: HomeNetworkWorkerProtocol,
        challengeFinishNetworkWorker: ChallengeFinishNetworkWorkerProtocol
    ) {
        self.homeLocalWorker = homeLocalWorker
        self.meLocalWorker = meLocalWorker
        self.homeNetworkWorker = homeNetworkWorker
        self.challengeFinishNetworkWorker = challengeFinishNetworkWorker
    }
    
    var challengeCompletedConfirmed: Bool {
        get {
            return self.homeLocalWorker.challengeCompletedConfirmed ?? false
        }
        set {
            self.homeLocalWorker.challengeCompletedConfirmed = newValue
        }
    }
    
    var bothCertificationConfirmed: Bool {
        get {
            return self.homeLocalWorker.bothCertificationConfirmed ?? false
        }
        set {
            self.homeLocalWorker.bothCertificationConfirmed = newValue
        }
    }
    
    func fetchHomeInfo() async throws -> Home.Model.HomeInfo {
        let homeResponse = try await self.homeNetworkWorker.requestHomeInquiry()
        
        var id: String = ""
        if let challengeNo = homeResponse.onGoingChallenge?.challengeNo {
            id = String(challengeNo)
        }
        
        let challengeStatus = self.mapChallengeStatus(from: homeResponse.viewState, homeResponse: homeResponse)
        
        var myInfo: Home.Model.User
        var partnerInfo: Home.Model.User
        
        if homeResponse.onGoingChallenge?.user1.userNo == self.meLocalWorker.userNo {
            myInfo = self.mapUserInfo(
                from: homeResponse.myInfo,
                commit: homeResponse.myCommit,
                flower: homeResponse.onGoingChallenge?.user1Flower,
                commitCount: homeResponse.onGoingChallenge?.user1CommitCnt
            )
            partnerInfo = self.mapUserInfo(
                from: homeResponse.partnerInfo,
                commit: homeResponse.partnerCommit,
                flower: homeResponse.onGoingChallenge?.user2Flower,
                commitCount: homeResponse.onGoingChallenge?.user2CommitCnt
            )
        }
        else {
            myInfo = self.mapUserInfo(
                from: homeResponse.myInfo,
                commit: homeResponse.myCommit,
                flower: homeResponse.onGoingChallenge?.user2Flower,
                commitCount: homeResponse.onGoingChallenge?.user2CommitCnt
            )
            partnerInfo = self.mapUserInfo(
                from: homeResponse.partnerInfo,
                commit: homeResponse.partnerCommit,
                flower: homeResponse.onGoingChallenge?.user1Flower,
                commitCount: homeResponse.onGoingChallenge?.user1CommitCnt
            )
        }
        
        let startDate = homeResponse.onGoingChallenge?.startDate.fullStringDate(.iso)
        let endDate = homeResponse.onGoingChallenge?.endDate.fullStringDate(.iso)
        
        self.meLocalWorker.userNo = homeResponse.myInfo.userNo
        self.meLocalWorker.nickname = homeResponse.myInfo.nickname
        self.meLocalWorker.partnerNo = homeResponse.partnerInfo.userNo
        self.meLocalWorker.partnerNickname = homeResponse.partnerInfo.nickname
        
        let challenge: Home.Model.Challenge = .init(
            id: id,
            name: homeResponse.onGoingChallenge?.name,
            startDate: startDate,
            endDate: endDate,
            order: homeResponse.challengeTotal,
            status: challengeStatus,
            myInfo: myInfo,
            partnerInfo: partnerInfo,
            stickRemaining: 3 - (homeResponse.myStingCnt ?? 0),
            description: homeResponse.onGoingChallenge?.description
        )
        
        return .init(challenge: challenge)
    }
    
    func requestChallengeComplete(challengeID: String) async throws {
        if let challengeNo = Int(challengeID) {
            _ = try await self.challengeFinishNetworkWorker.requestChallengeFinish(challengeNo: challengeNo)
            return
        }
        throw NSError(domain: "no challenge id", code: -1)
    }
    
    // MARK: - Mapping
    
    private func mapChallengeStatus(from viewState: HomeResponse.ViewState, homeResponse: HomeResponse) -> Home.Model.Status {
        switch viewState {
            case .BEFORE_CREATE:
                return .created
                
            case .BEFORE_MY_APPROVE:
                return .beforeStart
                
            case .BEFORE_PARTNER_APPROVE:
                return .waiting
                
            case .APPROVED_BUT_BEFORE_START_DATE:
                return .beforeStartDate
                
            case .IN_PROGRESS:
                if homeResponse.myCommit == nil && homeResponse.partnerCommit == nil {
                    return .inProgress(.bothUncertificated)
                }
                else if homeResponse.myCommit == nil {
                    return .inProgress(.onlyPartnerCertificated)
                }
                else if homeResponse.partnerCommit == nil {
                    return .inProgress(.onlyMeCertificated)
                }
                else {
                    if self.bothCertificationConfirmed {
                        return .inProgress(.bothCertificated(.comfirmed))
                    }
                    else {
                        return .inProgress(.bothCertificated(.uncomfirmed))
                    }
                }
            case .COMPLETE:
                if self.challengeCompletedConfirmed {
                    return .completed(.comfirmed)
                }
                else {
                    return .completed(.uncomfirmed)
                }
            case .EXPIRED_BY_NOT_APPROVED:
                return .afterStartDate
        }
    }

    private func mapUserInfo(from user: HomeResponse.User, commit: HomeResponse.Commit?, flower: HomeResponse.OnGoingChallenge.Flower?, commitCount: Int?) -> Home.Model.User {
        var userInfo: Home.Model.User = .init(
            id: String(user.userNo),
            nickname: user.nickname
        )
        
        if let commit = commit {
            userInfo.todayCert = .init(id: String(commit.commitNo), complimentComment: commit.partnerComment)
        }
        
        userInfo.certCount = commitCount ?? 0
        userInfo.growStatus = self.mapGrowStatus(from: commitCount) ?? .seed
        
        if let flower = flower {
            userInfo.flower = self.mapFlowerType(from: flower)
        }
        
        return userInfo
    }

    private func mapGrowStatus(from commitCount: Int?) -> Home.Model.GrowsStatus? {
        guard let commitCount = commitCount else {
            return .seed
        }
        switch commitCount {
        case 0:
            return .seed
        case 1...4:
            return .sprout
        case 5...9:
            return .bud
        case 10...15:
            return .peak
        case 16...21:
            return .bloom
        case 22:
            return .flower
        default:
            return nil
        }
    }

    private func mapFlowerType(from flower: HomeResponse.OnGoingChallenge.Flower) -> Flower? {
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
