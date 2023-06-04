//
//  ChallengeHistoryInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeHistoryBusinessLogic {}

protocol ChallengeHistoryDataStore: AnyObject {}

final class ChallengeHistoryInteractor: ChallengeHistoryDataStore, ChallengeHistoryBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeHistoryPresentationLogic
    var router: ChallengeHistoryRoutingLogic
    var worker: ChallengeHistoryWorkerProtocol
    
    init(
        presenter: ChallengeHistoryPresentationLogic,
        router: ChallengeHistoryRoutingLogic,
        worker: ChallengeHistoryWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ChallengeHistoryInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension ChallengeHistoryInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeHistoryInteractor {
    
}
