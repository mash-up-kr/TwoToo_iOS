//
//  HomeSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol HomeScene: AnyObject, Scene {
    
}

public struct HomeConfiguration {
    /// 히스토리 화면 이동 트리거
    /// - Parameters:
    ///     - 업데이트 여부 `Bool`
    public var didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never>
    
    public init(didTriggerRouteToHistoryScene: PassthroughSubject<Bool, Never>) {
        self.didTriggerRouteToHistoryScene = didTriggerRouteToHistoryScene
    }
}

public final class HomeSceneFactory {
    
    public init() {}
    
    public func make(with configuration: HomeConfiguration) -> HomeScene {
        
        let localDataSource = LocalDataSource()
        let homeLocalWorker = HomeLocalWorker(localDataSource: localDataSource)
        let meLocalWorker = MeLocalWorker(localDataSource: localDataSource)
        let homeNetworkWorker = HomeNetworkWorker()
        let challengeFinishWorker = ChallengeFinishWorker()
        
        let presenter = HomePresenter()
        let router = HomeRouter()
        let worker = HomeWorker(
            homeLocalWorker: homeLocalWorker,
            meLocalWorker: meLocalWorker,
            homeNetworkWorker: homeNetworkWorker,
            challengeFinishWorker: challengeFinishWorker
        )
        let interactor = HomeInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerRouteToHistoryScene: configuration.didTriggerRouteToHistoryScene
        )
        let viewController = HomeViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
