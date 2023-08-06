//
//  ChallengeCreateFinishRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeCreateFinishRoutingLogic {
    /// 화면을 닫는다.
    func dismiss()
}

final class ChallengeCreateFinishRouter {
    weak var viewController: ChallengeCreateFinishViewController?
    weak var dataStore: ChallengeCreateFinishDataStore?
}

extension ChallengeCreateFinishRouter: ChallengeCreateFinishRoutingLogic {
    func dismiss() {
        self.viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
