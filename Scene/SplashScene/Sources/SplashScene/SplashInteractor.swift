//
//  SplashInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol SplashBusinessLogic {
    /// 첫 진입
    func didLoad() async
}

protocol SplashDataStore: AnyObject {
    /// 로그인 화면 이동 트리거
    var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never> { get }
    /// 닉네임 설정 화면 이동 트리거
    var didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never> { get }
    /// 초대장 전송 화면 이동 트리거
    var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never> { get }
    /// 대기 화면 이동 트리거
    var didTriggerRouteToInvitationWaitScene: PassthroughSubject<Void, Never> { get }
    /// 홈 화면 이동 트리거
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never> { get }
}

final class SplashInteractor: SplashDataStore, SplashBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: SplashPresentationLogic
    var router: SplashRoutingLogic
    var worker: SplashWorkerProtocol
    
    init(
        presenter: SplashPresentationLogic,
        router: SplashRoutingLogic,
        worker: SplashWorkerProtocol,
        didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToInvitationWaitScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerRouteToLoginScene = didTriggerRouteToLoginScene
        self.didTriggerRouteToNickNameScene = didTriggerRouteToNickNameScene
        self.didTriggerRouteToInvitationSendScene = didTriggerRouteToInvitationSendScene
        self.didTriggerRouteToInvitationWaitScene = didTriggerRouteToInvitationWaitScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToLoginScene: PassthroughSubject<Void, Never>
    
    var didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>
    
    var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>
    
    var didTriggerRouteToInvitationWaitScene: PassthroughSubject<Void, Never>
    
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
}

// MARK: - Interactive Business Logic

extension SplashInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension SplashInteractor {
    
    func didLoad() async {
        do {
            let userState = try await self.worker.fetchUserState()
            switch userState {
                case .login:
                    self.didTriggerRouteToLoginScene.send(())
                    
                case .nickname:
                    self.didTriggerRouteToNickNameScene.send(())
                    
                case .invitationSend:
                    self.didTriggerRouteToInvitationSendScene.send(())
                    
                case .invitationWait:
                    self.didTriggerRouteToInvitationWaitScene.send(())
                    
                case .home:
                    self.didTriggerRouteToHomeScene.send(())
            }
        }
        catch {
            self.didTriggerRouteToLoginScene.send(())
        }
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension SplashInteractor {
    
}
