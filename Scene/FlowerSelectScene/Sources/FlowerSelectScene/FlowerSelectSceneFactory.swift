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
    /// 진입점 상태
    var enterSceneStatus: String
    /// 챌린지명
    let challengeName: String
    /// 챌린지 시작일
    let challengeStartDate: String
    /// 챌린지 종료일
    let challengeEndDate: String
    /// 챌린지 규칙
    let challengeRule: String?
    /// 챌린지 iD
    let challengeID: String?

    public init(
        didTriggerChallengeCreateScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>,
        enterSceneStatus: String,
        challengeName: String,
        challengeStartDate: String,
        challengeEndDate: String,
        challengeRule: String?,
        challengeID: String?
    ) {
        self.didTriggerChallengeCreateScene = didTriggerChallengeCreateScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
        self.enterSceneStatus = enterSceneStatus
        self.challengeName = challengeName
        self.challengeStartDate = challengeStartDate
        self.challengeEndDate = challengeEndDate
        self.challengeRule = challengeRule
        self.challengeID = challengeID
    }
}

public final class FlowerSelectSceneFactory {
    
    public init() {}

    public func make(with configuration: FlowerSelectConfiguration) -> FlowerSelectScene {
        
        let presenter = FlowerSelectPresenter()
        let challengeCreateWorker = FlowerSelectNetworkWorker()
        let challengeApproveWorker = ChallengeApproveNetworkWorker()

        let router = FlowerSelectRouter()
        let worker = FlowerSelectWorker(
            challengeCrateNetworkWorker: challengeCreateWorker,
            challengeApproveNetworkWorker: challengeApproveWorker
        )
        let interactor = FlowerSelectInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerChallengeCreateScene: configuration.didTriggerChallengeCreateScene,
            didTriggerRouteToHomeScene: configuration.didTriggerRouteToHomeScene,
            enterSceneStatus: configuration.enterSceneStatus,
            nameDataSource: configuration.challengeName,
            startDateDataSource: configuration.challengeStartDate,
            endDateDataSource: configuration.challengeEndDate,
            additionalInfoDataSource: configuration.challengeRule,
            challengeID: configuration.challengeID
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
