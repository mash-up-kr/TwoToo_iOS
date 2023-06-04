//
//  InvitationWaitRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol InvitationWaitRoutingLogic {}

final class InvitationWaitRouter {
    weak var viewController: InvitationWaitViewController?
    weak var dataStore: InvitationWaitDataStore?
}

extension InvitationWaitRouter: InvitationWaitRoutingLogic {
    
}
