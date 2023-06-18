//
//  InvitationWaitInteractor.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol InvitationWaitBusinessLogic {
    /// 첫 진입
    func didLoad() async
    /// 새로고침 클릭
    func didTapRefreshButton() async
    /// 초대장 다시 보내기 버튼 클릭
    func didTapResendButton() async
}

protocol InvitationWaitDataStore: AnyObject {
    /// 홈 화면 이동 트리거
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never> { get }
    /// 공유 링크 (optional)
    var invitationLink: String? { get }
}

final class InvitationWaitInteractor: InvitationWaitDataStore, InvitationWaitBusinessLogic {
    var cancellables: Set<AnyCancellable> = []
    
    var presenter: InvitationWaitPresentationLogic
    var router: InvitationWaitRoutingLogic
    var worker: InvitationWaitWorkerProtocol
    
    init(
        presenter: InvitationWaitPresentationLogic,
        router: InvitationWaitRoutingLogic,
        worker: InvitationWaitWorkerProtocol,
        didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>,
        invitationLink: String?
    ) {
        self.presenter = presenter
        self.router = router
        self.worker = worker
        self.didTriggerRouteToHomeScene = didTriggerRouteToHomeScene
        self.invitationLink = invitationLink
    }
    
    // MARK: - DataStore
    
    var didTriggerRouteToHomeScene: PassthroughSubject<Void, Never>
    
    var invitationLink: String?
}

// MARK: - Interactive Business Logic

extension InvitationWaitInteractor {
    
    /// 외부 액션 옵저빙
    func observe() {
        
    }
}

// MARK: Feature (진입)

extension InvitationWaitInteractor {
    
    func didLoad() async {
        if let invitationLink = self.invitationLink {
            await self.presenter.presentSharedActivity(invitationLink: invitationLink)
        }
        else {
            //
        }
    }
}

// MARK: Feature (새로고침)

extension InvitationWaitInteractor {
    
    func didTapRefreshButton() async {
        do {
            let partner = try await self.worker.inquiryPartner()
            if partner == nil {
                await self.presenter.presentAcceptanceWait()
            }
            else {
                self.didTriggerRouteToHomeScene.send(())
            }
        }
        catch {
            await self.presenter.presentPartnerInquiryError(error: error)
        }
    }
}

// MARK: Feature (초대장 다시 보내기)

extension InvitationWaitInteractor {
    
    func didTapResendButton() async {
        if let invitationLink = self.worker.invitationLink {
            await self.presenter.presentSharedActivity(invitationLink: invitationLink)
        }
        else {
            await self.presenter.presentInvitationLinkError()
        }
    }
}

// MARK: - Application Business Logic

// MARK: UseCase ()

extension InvitationWaitInteractor {
    
}
