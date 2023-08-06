//
//  ChallengeHistoryDetailRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeHistoryDetailRoutingLogic {
    /// 화면을 닫는다.
    func dismiss()
}

final class ChallengeHistoryDetailRouter {
    weak var viewController: ChallengeHistoryDetailViewController?
    weak var dataStore: ChallengeHistoryDetailDataStore?
}

extension ChallengeHistoryDetailRouter: ChallengeHistoryDetailRoutingLogic {
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
}
