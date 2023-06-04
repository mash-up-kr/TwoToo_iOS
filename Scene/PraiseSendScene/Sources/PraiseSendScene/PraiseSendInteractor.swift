//
//  PraiseSendInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol PraiseSendBusinessLogic {}

protocol PraiseSendDataStore: AnyObject {}

final class PraiseSendInteractor: PraiseSendDataStore, PraiseSendBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: PraiseSendPresentationLogic
    var router: PraiseSendRoutingLogic
    var worker: PraiseSendWorkerProtocol
    
    init(
        presenter: PraiseSendPresentationLogic,
        router: PraiseSendRoutingLogic,
        worker: PraiseSendWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension PraiseSendInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension PraiseSendInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension PraiseSendInteractor {
    
}
