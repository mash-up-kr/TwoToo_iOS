//
//  NudgeSendInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol NudgeSendBusinessLogic {}

protocol NudgeSendDataStore: AnyObject {}

final class NudgeSendInteractor: NudgeSendDataStore, NudgeSendBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: NudgeSendPresentationLogic
    var router: NudgeSendRoutingLogic
    var worker: NudgeSendWorkerProtocol
    
    init(
        presenter: NudgeSendPresentationLogic,
        router: NudgeSendRoutingLogic,
        worker: NudgeSendWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension NudgeSendInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension NudgeSendInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension NudgeSendInteractor {
    
}
