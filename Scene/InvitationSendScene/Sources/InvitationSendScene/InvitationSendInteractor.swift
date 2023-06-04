//
//  InvitationSendInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol InvitationSendBusinessLogic {}

protocol InvitationSendDataStore: AnyObject {}

final class InvitationSendInteractor: InvitationSendDataStore, InvitationSendBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: InvitationSendPresentationLogic
    var router: InvitationSendRoutingLogic
    var worker: InvitationSendWorkerProtocol
    
    init(
        presenter: InvitationSendPresentationLogic,
        router: InvitationSendRoutingLogic,
        worker: InvitationSendWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension InvitationSendInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension InvitationSendInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension InvitationSendInteractor {
    
}
