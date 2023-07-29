//
//  ChallengeCreateFinishInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol ChallengeCreateFinishBusinessLogic {
    func didTapConfimrButton() async
}

protocol ChallengeCreateFinishDataStore: AnyObject {}

final class ChallengeCreateFinishInteractor: ChallengeCreateFinishDataStore, ChallengeCreateFinishBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: ChallengeCreateFinishPresentationLogic
    var router: ChallengeCreateFinishRoutingLogic
    var worker: ChallengeCreateFinishWorkerProtocol
    
    init(
        presenter: ChallengeCreateFinishPresentationLogic,
        router: ChallengeCreateFinishRoutingLogic,
        worker: ChallengeCreateFinishWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
    }
    
    // MARK: - DataStore
    
}

// MARK: - Interactive Business Logic

extension ChallengeCreateFinishInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (페이지 이동)

extension ChallengeCreateFinishInteractor {
    func didTapConfimrButton() async {
        await self.router.dismiss()
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension ChallengeCreateFinishInteractor {
    
}
