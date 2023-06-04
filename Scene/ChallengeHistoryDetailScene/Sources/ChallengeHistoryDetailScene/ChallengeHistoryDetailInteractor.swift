//
//  ChallengeHistoryDetailInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeHistoryDetailBusinessLogic {}

protocol ChallengeHistoryDetailDataStore: AnyObject {}

final class ChallengeHistoryDetailInteractor: ChallengeHistoryDetailDataStore, ChallengeHistoryDetailBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeHistoryDetailPresentationLogic
    var router: ChallengeHistoryDetailRoutingLogic
    var worker: ChallengeHistoryDetailWorkerProtocol
    
    init(
        presenter: ChallengeHistoryDetailPresentationLogic,
        router: ChallengeHistoryDetailRoutingLogic,
        worker: ChallengeHistoryDetailWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ChallengeHistoryDetailInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension ChallengeHistoryDetailInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeHistoryDetailInteractor {
    
}
