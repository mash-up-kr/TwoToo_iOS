//
//  ChallengeHistorySceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

@MainActor
public protocol ChallengeHistoryScene: AnyObject, Scene {
    
}

public struct ChallengeHistoryConfiguration {
    /// 챌린지 ID
    public var challengeID: String
    
    public init(challengeID: String) {
        self.challengeID = challengeID
    }
}

public final class ChallengeHistorySceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeHistoryConfiguration) -> ChallengeHistoryScene {
        
        let meLocalWorker = MeLocalWorker(localDataSource: LocalDataSource())
        let challengeDetailNetworkWorker = ChallengeDetailNetworkWorker()
        let challengeQuitNetworkWorker = ChallengeQuitNetworkWorker()
        
        let presenter = ChallengeHistoryPresenter()
        let router = ChallengeHistoryRouter()
        let worker = ChallengeHistoryWorker(
            meLocalWorker: meLocalWorker,
            challengeDetailNetworkWorker: challengeDetailNetworkWorker,
            challengeQuitNetworkWorker: challengeQuitNetworkWorker
        )
        let interactor = ChallengeHistoryInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            challengeID: configuration.challengeID
        )
        let viewController = ChallengeHistoryViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
