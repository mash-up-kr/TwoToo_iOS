//
//  NudgeSendRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol NudgeSendRoutingLogic {
    /// 화면을 닫는다.
    func dismiss()
}

final class NudgeSendRouter {
    weak var viewController: NudgeSendViewController?
    weak var dataStore: NudgeSendDataStore?
}

extension NudgeSendRouter: NudgeSendRoutingLogic {
    
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
