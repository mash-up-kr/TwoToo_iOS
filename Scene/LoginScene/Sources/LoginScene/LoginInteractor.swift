//
//  LoginInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol LoginBusinessLogic {}

protocol LoginDataStore: AnyObject {}

final class LoginInteractor: LoginDataStore, LoginBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: LoginPresentationLogic
    var router: LoginRoutingLogic
    var worker: LoginWorkerProtocol
    
    init(
        presenter: LoginPresentationLogic,
        router: LoginRoutingLogic,
        worker: LoginWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension LoginInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension LoginInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension LoginInteractor {
    
}
