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
}

final class ChallengeConfirmWorker: ChallengeConfirmWorkerProtocol {

    func fetchChallengeConfirmInfo() async throws -> ChallengeConfirm.Model.ConfirmStatus {
        return .confirm
    }
}
