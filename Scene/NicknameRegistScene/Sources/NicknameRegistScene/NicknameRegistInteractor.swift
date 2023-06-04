//
//  NicknameRegistInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol NicknameRegistBusinessLogic {}

protocol NicknameRegistDataStore: AnyObject {}

final class NicknameRegistInteractor: NicknameRegistDataStore, NicknameRegistBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: NicknameRegistPresentationLogic
    var router: NicknameRegistRoutingLogic
    var worker: NicknameRegistWorkerProtocol
    
    init(
        presenter: NicknameRegistPresentationLogic,
        router: NicknameRegistRoutingLogic,
        worker: NicknameRegistWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension NicknameRegistInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension NicknameRegistInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension NicknameRegistInteractor {
    
}
