//
//  MyInfoInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol MyInfoBusinessLogic {}

protocol MyInfoDataStore: AnyObject {}

final class MyInfoInteractor: MyInfoDataStore, MyInfoBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: MyInfoPresentationLogic
    var router: MyInfoRoutingLogic
    var worker: MyInfoWorkerProtocol
    
    init(
        presenter: MyInfoPresentationLogic,
        router: MyInfoRoutingLogic,
        worker: MyInfoWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension MyInfoInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension MyInfoInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension MyInfoInteractor {
    
}
