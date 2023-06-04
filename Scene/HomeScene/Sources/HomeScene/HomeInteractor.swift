//
//  HomeInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol HomeBusinessLogic {}

protocol HomeDataStore: AnyObject {}

final class HomeInteractor: HomeDataStore, HomeBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: HomePresentationLogic
    var router: HomeRoutingLogic
    var worker: HomeWorkerProtocol
    
    init(
        presenter: HomePresentationLogic,
        router: HomeRoutingLogic,
        worker: HomeWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension HomeInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension HomeInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension HomeInteractor {
    
}
