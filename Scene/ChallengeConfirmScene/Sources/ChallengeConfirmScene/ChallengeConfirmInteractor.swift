//
//  ChallengeConfirmInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeConfirmBusinessLogic {}

protocol ChallengeConfirmDataStore: AnyObject {}

final class ChallengeConfirmInteractor: ChallengeConfirmDataStore, ChallengeConfirmBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeConfirmPresentationLogic
    var router: ChallengeConfirmRoutingLogic
    var worker: ChallengeConfirmWorkerProtocol
    
    init(
        presenter: ChallengeConfirmPresentationLogic,
        router: ChallengeConfirmRoutingLogic,
        worker: ChallengeConfirmWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ChallengeConfirmInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension ChallengeConfirmInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeConfirmInteractor {
    
}
