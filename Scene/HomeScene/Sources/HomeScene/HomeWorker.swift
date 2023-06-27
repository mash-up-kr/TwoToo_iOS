//
//  HomeWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

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
    
    // TODO: UD에서 챌린지 완료 확인 여부를 업데이트 및 추출하는 작업 필요
    var challengeCompletedConfirmed: Bool {
        get {
            return false
        }
        set {
            
        }
    }
    
    // TODO: UD에서 둘다 인증 확인 여부를 업데이트 및 추출하는 작업 필요
    var bothCertificationConfirmed: Bool {
        get {
            return false
        }
        set {
            
        }
    }
    
    func fetchHomeInfo() async throws -> Home.Model.HomeInfo {
        return .init(challenge: .init(status: .afterStartDate, myInfo: .init(id: "", nickname: ""), partnerInfo: .init(id: "", nickname: "")))
    }
    
    func requestChallengeComplete(challengeID: String) async throws {
        
    }
}
