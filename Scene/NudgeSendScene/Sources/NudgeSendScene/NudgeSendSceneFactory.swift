//
//  NudgeSendSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import CoreKit

@MainActor
public protocol NudgeSendScene: AnyObject, Scene {
    
}

public struct NudgeSendConfiguration {
    /// 남은 찌르기 횟수
    public var remainingNudgeCount: Int
    
    public init(remainingNudgeCount: Int) {
        self.remainingNudgeCount = remainingNudgeCount
    }
}

public final class NudgeSendSceneFactory {
    
    public init() {}
    
    public func make(with configuration: NudgeSendConfiguration) -> NudgeSendScene {
        
        let presenter = NudgeSendPresenter()
        let router = NudgeSendRouter()
        let worker = NudgeSendWorker()
        let interactor = NudgeSendInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            remainingNudgeCount: configuration.remainingNudgeCount
        )
        let viewController = NudgeSendViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
