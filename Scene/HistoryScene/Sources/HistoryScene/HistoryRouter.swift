//
//  HistoryRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import ChallengeHistoryScene
import WebKit

@MainActor
protocol HistoryRoutingLogic {
    /// 챌린지 히스토리 상세 화면을 연다.
    func routeToChallengeHistoryScene(model: History.Model.Challenge)
    /// 설명서 화면을 연다.
    func routeToManualScene()
}

final class HistoryRouter {
    weak var viewController: HistoryViewController?
    weak var dataStore: HistoryDataStore?
}

extension HistoryRouter: HistoryRoutingLogic {
    func routeToChallengeHistoryScene(model: History.Model.Challenge) {
        // TODO: - ChallengeHistoryScene
    }
    
    func routeToManualScene() {
        // TODO: - WebView
    }
    
}
