//
//  SplashSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol SplashScene: AnyObject, Scene {
    
}

public struct SplashConfiguration {
    /// 로그인 화면 이동 트리거
    public var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>
    /// 닉네임 설정 화면 이동 트리거
    public var didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>
    /// 초대장 전송 화면 이동 트리거
    public var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>
    /// 대기 화면 이동 트리거
    public var didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>
    /// 홈 화면 이동 트리거
    public var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    
    public init(didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>, didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>, didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>, didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>, didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>) {
        self.didTriggerRouteToLoginScene = didTriggerRouteToLoginScene
        self.didTriggerRouteToNickNameScene = didTriggerRouteToNickNameScene
        self.didTriggerRouteToInvitationSendScene = didTriggerRouteToInvitationSendScene
        self.didTriggerRouteToInvitationWaitScene = didTriggerRouteToInvitationWaitScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
    }
}

public final class SplashSceneFactory {
    
    public init() {}
    
    public func make(with configuration: SplashConfiguration) -> SplashScene {
        
        let localDataSource = LocalDataSource()
        let meLocalWorker = MeLocalWorker(localDataSource: localDataSource)
        let invitationLocalWorker = InvitationLocalWorker(localDataSource: localDataSource)
        let meNetworkWorker = MeNetworkWorker()
        let appVersionWorker = AppVersionNetworkWorker()
        
        let presenter = SplashPresenter()
        let router = SplashRouter()
        let worker = SplashWorker(
            meLocalWorker: meLocalWorker,
            invitationLocalWorker: invitationLocalWorker,
            meNetworkWorker: meNetworkWorker,
            appVersionWorker: appVersionWorker
        )
        let interactor = SplashInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerRouteToLoginScene: configuration.didTriggerRouteToLoginScene,
            didTriggerRouteToNickNameScene: configuration.didTriggerRouteToNickNameScene,
            didTriggerRouteToInvitationSendScene: configuration.didTriggerRouteToInvitationSendScene,
            didTriggerRouteToInvitationWaitScene: configuration.didTriggerRouteToInvitationWaitScene,
            didTriggerRouteToHomeScene: configuration.didTriggerRouteToHomeScene
        )
        let viewController = SplashViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
