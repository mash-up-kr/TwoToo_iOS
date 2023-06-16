//
//  NicknameRegistInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol NicknameRegistBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 닉네임 입력
    func didEnterNickname(text: String) async
    /// 확인 버튼 클릭
    func didTapConfirmButton() async
}

protocol NicknameRegistDataStore: AnyObject {
    /// 초대장 전송 화면 이동 트리거
    var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never> { get }
    /// 홈 화면 이동 트리거
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never> { get }
    /// 닉네임
    var nickname: String { get }
}

final class NicknameRegistInteractor: NicknameRegistDataStore, NicknameRegistBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: NicknameRegistPresentationLogic
    var router: NicknameRegistRoutingLogic
    var worker: NicknameRegistWorkerProtocol
    
    init(
        presenter: NicknameRegistPresentationLogic,
        router: NicknameRegistRoutingLogic,
        worker: NicknameRegistWorkerProtocol,
        didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerRouteToInvitationSendScene = didTriggerRouteToInvitationSendScene
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToInvitationSendScene: PassthroughSubject<Void, Never>
    
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    
    var nickname: String = ""
    
    private func updateNickname(_ nickname: String) async {
        self.nickname = nickname
        await didUpdateNickname()
    }
}

// MARK: - Interactive Business Logic

extension NicknameRegistInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension NicknameRegistInteractor {
    
    func didLoad() async {
        
    }
}

// MARK: Feature (닉네임 입력)

extension NicknameRegistInteractor {
    
    func didEnterNickname(text: String) async {
        
    }
}

// MARK: Feature (닉네임 설정 & 매칭)

extension NicknameRegistInteractor {
    
    func didTapConfirmButton() async {
        
    }
}

// MARK: - Common Interactive Business Logic

extension NicknameRegistInteractor {
    
    /// 닉네임 데이터 업데이트 됨
    func didUpdateNickname() async {
        
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension NicknameRegistInteractor {
    
}
