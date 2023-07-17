//
//  InvitationWaitPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol InvitationWaitPresentationLogic {
    /// 공유하기 화면을 보여준다.
    func presentSharedActivity(invitationLink: String)
    /// 수락 대기 안내를 보여준다.
    func presentAcceptanceWait()
    /// 파트너 조회 오류를 보여준다.
    func presentPartnerInquiryError(error: Error)
    /// 공유 링크 오류를 보여준다.
    func presentInvitationLinkError()
}

final class InvitationWaitPresenter {
    weak var viewController: InvitationWaitDisplayLogic?
    
}

// MARK: - Presentation Logic

extension InvitationWaitPresenter: InvitationWaitPresentationLogic {
    
    func presentSharedActivity(invitationLink: String) {
        self.viewController?.displayShare(viewModel: .init(invitationLink: invitationLink))
    }
    
    func presentAcceptanceWait() {
        self.viewController?.displayToast(viewModel: .init(message: "상대방이 아직 수락을 하지 않았어요!"))
    }
    
    func presentPartnerInquiryError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: "새로고침이 실패하였습니다. 다시 시도해주세요."))
    }
    
    func presentInvitationLinkError() {
        self.viewController?.displayToast(viewModel: .init(message: "공유 링크가 존재하지 않습니다. 다시 시도해주세요."))
    }
}
