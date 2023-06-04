//
//  HistoryInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol HistoryBusinessLogic {}

protocol HistoryDataStore: AnyObject {}

final class HistoryInteractor: HistoryDataStore, HistoryBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: HistoryPresentationLogic
    var router: HistoryRoutingLogic
    var worker: HistoryWorkerProtocol
    
    init(
        presenter: HistoryPresentationLogic,
        router: HistoryRoutingLogic,
        worker: HistoryWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension HistoryInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension HistoryInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension HistoryInteractor {
    
}
