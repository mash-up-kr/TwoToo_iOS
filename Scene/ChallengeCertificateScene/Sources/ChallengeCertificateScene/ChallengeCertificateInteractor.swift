//
//  ChallengeCertificateInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeCertificateBusinessLogic {}

protocol ChallengeCertificateDataStore: AnyObject {}

final class ChallengeCertificateInteractor: ChallengeCertificateDataStore, ChallengeCertificateBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeCertificatePresentationLogic
    var router: ChallengeCertificateRoutingLogic
    var worker: ChallengeCertificateWorkerProtocol
    
    init(
        presenter: ChallengeCertificatePresentationLogic,
        router: ChallengeCertificateRoutingLogic,
        worker: ChallengeCertificateWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ChallengeCertificateInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature ()

extension ChallengeCertificateInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeCertificateInteractor {
    
}
