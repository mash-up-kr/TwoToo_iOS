//
//  MainInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol MainBusinessLogic {
    /// 첫진입
    func didLoad() async
}

protocol MainDataStore: AnyObject {
    /// 히스토리 화면 이동 트리거
    /// - Parameters:
    ///     - 업데이트 여부 `Bool`
    var didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never> { get }
}

final class MainInteractor: MainDataStore, MainBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: MainPresentationLogic
    var router: MainRoutingLogic
    var worker: MainWorkerProtocol
    
    init(
        presenter: MainPresentationLogic,
        router: MainRoutingLogic,
        worker: MainWorkerProtocol
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        
        self.observe()
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never> = .init()
}

// MARK: - Interactive Business Logic

extension MainInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension MainInteractor {
    
    func didLoad() async {
        await self.router.setTabViewControllers()
    }
}

// MARK: Feature ()

extension MainInteractor {
    
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension MainInteractor {
    
}
