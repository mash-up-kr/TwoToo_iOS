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
    /// 로그인 화면 이동 트리거
    var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never> { get }
}

final class MainInteractor: MainDataStore, MainBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: MainPresentationLogic
    var router: MainRoutingLogic
    var worker: MainWorkerProtocol
    
    init(
        presenter: MainPresentationLogic,
        router: MainRoutingLogic,
        worker: MainWorkerProtocol,
        didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerRouteToLoginScene = didTriggerRouteToLoginScene
        
        self.observe()
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never> = .init()
    
    var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>
}

// MARK: - Interactive Business Logic

extension MainInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
        self.didTriggerRouteToHistoryScene
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                Task { @MainActor in
                    self.router.switchHistoryTab()
                }
            }
            .store(in: &self.cancellables)
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
