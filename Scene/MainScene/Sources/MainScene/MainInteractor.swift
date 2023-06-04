//
//  MainInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol MainBusinessLogic {}

protocol MainDataStore: AnyObject {}

final class MainInteractor: MainDataStore, MainBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: MainPresentationLogic
    var router: MainRoutingLogic
    var worker: MainWorkerProtocol
    
    init(
        presenter: MainPresentationLogic,
        router: MainRoutingLogic,
        worker: MainWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension MainInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension MainInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension MainInteractor {
    
}
