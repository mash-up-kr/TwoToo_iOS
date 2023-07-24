//
//  ChallengeConfirmWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeConfirmWorkerProtocol {
    func fetchChallengeConfirmInfo() async throws -> ChallengeConfirm.Model.ConfirmStatus
    func fetchChallengeInfo() async throws -> ChallengeConfirm.Model.ChallengeInfo
}

final class ChallengeConfirmWorker: ChallengeConfirmWorkerProtocol {

    // TODO: - 추후 상태 값 받아와서 변경
    func fetchChallengeConfirmInfo() async throws -> ChallengeConfirm.Model.ConfirmStatus {
        return .accept
    }
    
    // TODO: - 추후 값 받아와서 주입
    func fetchChallengeInfo() async throws -> ChallengeConfirm.Model.ChallengeInfo {
        return .init(title: "운동하기", startDate: "23/05/12", endDate: "23/05/25", rule: "안하면 뷔폐 쏘기!")
    }
}
