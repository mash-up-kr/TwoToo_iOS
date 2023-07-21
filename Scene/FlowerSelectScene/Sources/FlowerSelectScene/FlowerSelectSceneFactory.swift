//
//  FlowerSelectSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol FlowerSelectScene: AnyObject, Scene {
    
}

public struct FlowerSelectConfiguration {
    /// 챌린지 생성완료 화면 이동 트리거
    var didTriggerChallengeCreateScene: PassthroughSubject<Void, Never>
    /// 홈 화면 이동 트리거
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>

    public init(
    var didTriggerChallengeCreateScene: PassthroughSubject<Void, Never>,
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    ) {
        self.didTriggerChallengeCreateScene = didTriggerChallengeCreateScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
    }
}

public final class FlowerSelectSceneFactory {
    
    public init() {}

    public func make(with configuration: FlowerSelectConfiguration) -> FlowerSelectScene {
        
        let presenter = FlowerSelectPresenter()
        let router = FlowerSelectRouter()
        let worker = FlowerSelectWorker()
        let interactor = FlowerSelectInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerChallengeCreateScene: configuration.didTriggerChallengeCreateScene,
            didTriggerRouteToHomeScene: configuration.didTriggerRouteToHomeScene
        )
        let viewController = FlowerSelectViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
