//
//  SplashInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol SplashBusinessLogic {}

protocol SplashDataStore: AnyObject {}

final class SplashInteractor: SplashDataStore, SplashBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: SplashPresentationLogic
    var router: SplashRoutingLogic
    var worker: SplashWorkerProtocol
    
    init(
        presenter: SplashPresentationLogic,
        router: SplashRoutingLogic,
        worker: SplashWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension SplashInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension SplashInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension SplashInteractor {
    
}
