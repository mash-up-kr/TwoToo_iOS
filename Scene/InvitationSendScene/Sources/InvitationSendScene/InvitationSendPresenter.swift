//
//  InvitationSendPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol InvitationSendPresentationLogic {
    /// 공유 링크 생성 오류를 보여준다.
    func presentInvitaitonLinkCreateError(error: Error)
}

final class InvitationSendPresenter {
    weak var viewController: InvitationSendDisplayLogic?
    
}

// MARK: - Presentation Logic

extension InvitationSendPresenter: InvitationSendPresentationLogic {
    
    func presentInvitaitonLinkCreateError(error: Error) {
        
    }
}
