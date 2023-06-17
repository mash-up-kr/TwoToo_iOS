//
//  LoginInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol LoginBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 카카오 로그인 버튼 클릭
    func didTapKakaoLoginButton() async
    /// 애플 로그인 버튼 클릭
    func didTapAppleLoginButton() async
    /// 온보딩 스와이프
    func didSwipeOnboarding(index: Int) async
}

protocol LoginDataStore: AnyObject {
    /// 닉네임 설정 화면 이동 트리거
    var didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never> { get }
    /// 초대장 전송 화면 이동 트리거
    var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never> { get }
    /// 대기 화면 이동 트리거
    var didTriggerRouteToInvitationWaitScene: PassthroughSubject<Void, Never> { get }
    /// 홈 화면 이동 트리거
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never> { get }
}

final class LoginInteractor: LoginDataStore, LoginBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: LoginPresentationLogic
    var router: LoginRoutingLogic
    var worker: LoginWorkerProtocol
    
    init(
        presenter: LoginPresentationLogic,
        router: LoginRoutingLogic,
        worker: LoginWorkerProtocol,
        didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToInvitationWaitScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerRouteToNickNameScene = didTriggerRouteToNickNameScene
        self.didTriggerRouteToInvitationSendScene = didTriggerRouteToInvitationSendScene
        self.didTriggerRouteToInvitationWaitScene = didTriggerRouteToInvitationWaitScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToNickNameScene: PassthroughSubject<Void, Never>
    
    var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>
    
    var didTriggerRouteToInvitationWaitScene: PassthroughSubject<Void, Never>
    
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
}

// MARK: - Interactive Business Logic

extension LoginInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension LoginInteractor {
    
    func didLoad() async {
        
    }
}

// MARK: Feature (로그인)

extension LoginInteractor {
    
    func didTapKakaoLoginButton() async {
        
    }
    
    func didTapAppleLoginButton() async {
        
    }
}

// MARK: Feature (온보딩)

extension LoginInteractor {
    
    func didSwipeOnboarding(index: Int) async {
        
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension LoginInteractor {
    
}
