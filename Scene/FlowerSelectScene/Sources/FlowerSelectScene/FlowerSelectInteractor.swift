//
//  FlowerSelectInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol FlowerSelectBusinessLogic {
    /// 첫진입
    func didLoad() async
    /// 꽃 선택
    func didTapFlower() async
    /// 챌린지 버튼 클릭
    func didTapButton() async
}

protocol FlowerSelectDataStore: AnyObject {
    /// 챌린지 생성완료 화면 이동 트리거
    var didTriggerChallengeCreateScene: PassthroughSubject<Void, Never> { get }
    /// 홈 화면 이동 트리거
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never> { get }
}

final class FlowerSelectInteractor: FlowerSelectDataStore, FlowerSelectBusinessLogic {

    var cancellables: Set<AnyCancellable> = []
    
    var presenter: FlowerSelectPresentationLogic
    var router: FlowerSelectRoutingLogic
    var worker: FlowerSelectWorkerProtocol
    
    init(
        presenter: FlowerSelectPresentationLogic,
        router: FlowerSelectRoutingLogic,
        worker: FlowerSelectWorkerProtocol,
        didTriggerChallengeCreateScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerChallengeCreateScene = didTriggerChallengeCreateScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
    }
    
    // MARK: - DataStore

    var didTriggerChallengeCreateScene: PassthroughSubject<Void, Never>

    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
}

// MARK: - Interactive Business Logic

extension FlowerSelectInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension FlowerSelectInteractor {
    func didLoad() async {

    }
}

// MARK: Feature (꽃선택)
extension FlowerSelectInteractor {
    func didTapFlower() async {

    }
}

// MARK: Feature (챌린지 생성, 시작)
extension FlowerSelectInteractor {
    func didTapButton() async {

    }
}

// MARK: Feature (꽃선택)
extension FlowerSelectInteractor {

}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension FlowerSelectInteractor {
    
}
