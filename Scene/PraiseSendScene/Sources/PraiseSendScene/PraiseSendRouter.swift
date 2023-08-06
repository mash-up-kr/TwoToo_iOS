//
//  PraiseSendRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol PraiseSendRoutingLogic {
    /// 화면을 닫는다.
    func dismiss()
}

final class PraiseSendRouter {
    weak var viewController: PraiseSendViewController?
    weak var dataStore: PraiseSendDataStore?
}

extension PraiseSendRouter: PraiseSendRoutingLogic {
    
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
