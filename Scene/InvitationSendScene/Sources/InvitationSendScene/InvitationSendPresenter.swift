//
//  InvitationSendPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol InvitationSendPresentationLogic {}

final class InvitationSendPresenter {
    weak var viewController: InvitationSendDisplayLogic?
    
}

// MARK: - Presentation Logic

extension InvitationSendPresenter: InvitationSendPresentationLogic {
    
}
