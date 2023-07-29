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
    func didTapFlower(flowerIndex: Int?) async
    /// 챌린지 버튼 클릭
    func didTapButton() async
}

protocol FlowerSelectDataStore: AnyObject {
    /// 챌린지 생성완료 화면 이동 트리거
    var didTriggerChallengeCreateScene: PassthroughSubject<Void, Never> { get }
    /// 홈 화면 이동 트리거
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never> { get }
    /// 진입점 트리거
    var enterSceneStatus: String { get }
    /// 선택된 꽃
    var selectedFlower: String { get }
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
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>,
        didEnterFlowerSelectScene: String,
        selectedFlower: String
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerChallengeCreateScene = didTriggerChallengeCreateScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
        self.enterSceneStatus = didEnterFlowerSelectScene
        self.selectedFlower = selectedFlower
    }
    
    // MARK: - DataStore

    var didTriggerChallengeCreateScene: PassthroughSubject<Void, Never>

    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    
    var enterSceneStatus: String

    var selectedFlower: String
    
    enum EnterSceneStatus: String {
        case create = "create"
        case accept = "accept"
    }
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
        let status = EnterSceneStatus(rawValue: self.enterSceneStatus)

        enterSceneStatus = status?.rawValue ?? "create"

        switch status {
        case .create:
            await self.presenter.presentCreateScene(model: .init(isHidden: true, title: .create))
            await self.presenter.presentFlowers()
        case .accept:
            await self.presenter.presentAceeptScene(model: .init(isHidden: true, title: .accpet))
            await self.presenter.presentFlowers()
        case .none:
            await self.presenter.presentCreateScene(model: .init(isHidden: true, title: .create))
            await self.presenter.presentFlowers()
        }
    }
}

// MARK: Feature (꽃선택)
extension FlowerSelectInteractor {
    func didTapFlower(flowerIndex: Int?) async {

        guard let flower = Flower(rawValue: flowerIndex ?? 0) else { return }

        selectedFlower = flower.name

        await self.presenter.selectFlower(model: .init(indexPath: flowerIndex))
    }
}

// MARK: Feature (챌린지 생성, 시작)
extension FlowerSelectInteractor {
    func didTapButton() async {

    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension FlowerSelectInteractor {
    
}
