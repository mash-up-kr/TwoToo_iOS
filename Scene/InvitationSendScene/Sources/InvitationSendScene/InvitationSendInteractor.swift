//
//  InvitationSendInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol InvitationSendBusinessLogic {
    /// 초대장 보내기 버튼 클릭
    func didTapInvitationSendButton() async
}

protocol InvitationSendDataStore: AnyObject {
    /// 대기 화면 이동 트리거
    var didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never> { get }
}

final class InvitationSendInteractor: InvitationSendDataStore, InvitationSendBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: InvitationSendPresentationLogic
    var router: InvitationSendRoutingLogic
    var worker: InvitationSendWorkerProtocol
    
    init(
        presenter: InvitationSendPresentationLogic,
        router: InvitationSendRoutingLogic,
        worker: InvitationSendWorkerProtocol,
        didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerRouteToInvitationWaitScene = didTriggerRouteToInvitationWaitScene
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToInvitationWaitScene: PassthroughSubject<String?, Never>
}

// MARK: - Interactive Business Logic

extension InvitationSendInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (초대장 보내기)

extension InvitationSendInteractor {
    
    func didTapInvitationSendButton() async {
        do {
            let link = try await self.worker.requestInvitationLinkCreate()
            self.worker.isInvitationSend = true
            self.didTriggerRouteToInvitationWaitScene.send(link)
        }
        catch {
            await self.presenter.presentInvitaitonLinkCreateError(error: error)
        }
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension InvitationSendInteractor {
    
}
