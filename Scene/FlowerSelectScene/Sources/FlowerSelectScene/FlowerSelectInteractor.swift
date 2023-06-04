//
//  FlowerSelectInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol FlowerSelectBusinessLogic {}

protocol FlowerSelectDataStore: AnyObject {}

final class FlowerSelectInteractor: FlowerSelectDataStore, FlowerSelectBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: FlowerSelectPresentationLogic
    var router: FlowerSelectRoutingLogic
    var worker: FlowerSelectWorkerProtocol
    
    init(
        presenter: FlowerSelectPresentationLogic,
        router: FlowerSelectRoutingLogic,
        worker: FlowerSelectWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension FlowerSelectInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension FlowerSelectInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension FlowerSelectInteractor {
    
}
