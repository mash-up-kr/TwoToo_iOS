//
//  ChallengeRecommendInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeRecommendBusinessLogic {}

protocol ChallengeRecommendDataStore: AnyObject {}

final class ChallengeRecommendInteractor: ChallengeRecommendDataStore, ChallengeRecommendBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeRecommendPresentationLogic
    var router: ChallengeRecommendRoutingLogic
    var worker: ChallengeRecommendWorkerProtocol
    
    init(
        presenter: ChallengeRecommendPresentationLogic,
        router: ChallengeRecommendRoutingLogic,
        worker: ChallengeRecommendWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ChallengeRecommendInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension ChallengeRecommendInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeRecommendInteractor {
    
}
