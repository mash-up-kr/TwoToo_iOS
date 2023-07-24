//
//  ChallengeRecommendSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit

@MainActor
public protocol ChallengeRecommendScene: AnyObject, Scene {
    var bottomSheetViewController: UIViewController { get }
}

public struct ChallengeRecommendConfiguration {
    /// 챌린지 이름 선택 트리거
    public var didTriggerSelectChallengeName: PassthroughSubject<String, Never>
    
    public init(didTriggerSelectChallengeName: PassthroughSubject<String, Never>) {
        self.didTriggerSelectChallengeName = didTriggerSelectChallengeName
    }
}

public final class ChallengeRecommendSceneFactory {
    
    public init() {}
    
    public func make(with configuration: ChallengeRecommendConfiguration) -> ChallengeRecommendScene {
        
        let presenter = ChallengeRecommendPresenter()
        let router = ChallengeRecommendRouter()
        let worker = ChallengeRecommendWorker()
        let interactor = ChallengeRecommendInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerSelectChallengeName: configuration.didTriggerSelectChallengeName
        )
        let viewController = ChallengeRecommendViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
