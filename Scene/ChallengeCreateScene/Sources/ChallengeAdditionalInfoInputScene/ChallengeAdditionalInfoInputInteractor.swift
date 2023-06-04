//
//  ChallengeAdditionalInfoInputInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeAdditionalInfoInputBusinessLogic {}

protocol ChallengeAdditionalInfoInputDataStore: AnyObject {}

final class ChallengeAdditionalInfoInputInteractor: ChallengeAdditionalInfoInputDataStore, ChallengeAdditionalInfoInputBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeAdditionalInfoInputPresentationLogic
    var router: ChallengeAdditionalInfoInputRoutingLogic
    var worker: ChallengeAdditionalInfoInputWorkerProtocol
    
    init(
        presenter: ChallengeAdditionalInfoInputPresentationLogic,
        router: ChallengeAdditionalInfoInputRoutingLogic,
        worker: ChallengeAdditionalInfoInputWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ChallengeAdditionalInfoInputInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension ChallengeAdditionalInfoInputInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeAdditionalInfoInputInteractor {
    
}
