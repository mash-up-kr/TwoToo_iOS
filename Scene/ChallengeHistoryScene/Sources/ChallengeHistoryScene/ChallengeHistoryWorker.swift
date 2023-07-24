//
//  ChallengeHistoryWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeHistoryWorkerProtocol {
    /// 챌린지 그만두기 요청을 한다.
    func requestChallengeQuit(challengeID: String) async throws
}

final class ChallengeHistoryWorker: ChallengeHistoryWorkerProtocol {
    
    func requestChallengeQuit(challengeID: String) async throws {
        
    }
}
