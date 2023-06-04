//
//  InvitationWaitInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol InvitationWaitBusinessLogic {}

protocol InvitationWaitDataStore: AnyObject {}

final class InvitationWaitInteractor: InvitationWaitDataStore, InvitationWaitBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: InvitationWaitPresentationLogic
    var router: InvitationWaitRoutingLogic
    var worker: InvitationWaitWorkerProtocol
    
    init(
        presenter: InvitationWaitPresentationLogic,
        router: InvitationWaitRoutingLogic,
        worker: InvitationWaitWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension InvitationWaitInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension InvitationWaitInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension InvitationWaitInteractor {
    
}
