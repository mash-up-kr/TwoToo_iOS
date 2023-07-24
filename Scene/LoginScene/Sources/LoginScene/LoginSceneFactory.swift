//
//  LoginSceneFactory.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

@MainActor
public protocol LoginScene: AnyObject, Scene {
    
}

public struct LoginConfiguration {
    /// 닉네임 설정 화면 이동 트리거
    public var didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>
    /// 초대장 전송 화면 이동 트리거
    public var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>
    /// 대기 화면 이동 트리거
    public var didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>
    /// 홈 화면 이동 트리거
    public var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>

    public init(
        didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    ) {
        self.didTriggerRouteToNickNameScene = didTriggerRouteToNickNameScene
        self.didTriggerRouteToInvitationSendScene = didTriggerRouteToInvitationSendScene
        self.didTriggerRouteToInvitationWaitScene = didTriggerRouteToInvitationWaitScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
    }
}

public final class LoginSceneFactory {
    
    public init() {}
    
    public func make(with configuration: LoginConfiguration) -> LoginScene {
        
        let presenter = LoginPresenter()
        let router = LoginRouter()
        let worker = LoginWorker()
        let interactor = LoginInteractor(
            presenter: presenter,
            router: router,
            worker: worker,
            didTriggerRouteToNickNameScene: configuration.didTriggerRouteToNickNameScene,
            didTriggerRouteToInvitationSendScene: configuration.didTriggerRouteToInvitationSendScene,
            didTriggerRouteToInvitationWaitScene: configuration.didTriggerRouteToInvitationWaitScene,
            didTriggerRouteToHomeScene: configuration.didTriggerRouteToHomeScene
        )
        let viewController = LoginViewController(
            interactor: interactor
        )
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
}
