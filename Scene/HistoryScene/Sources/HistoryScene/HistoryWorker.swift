//
//  HistoryWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol HistoryWorkerProtocol {
    func fetchChallengeList() async throws -> History.Model.ChallengeList
}

final class HistoryWorker: HistoryWorkerProtocol {
    
    func fetchChallengeList() async throws -> History.Model.ChallengeList {
        return []
    }
}
