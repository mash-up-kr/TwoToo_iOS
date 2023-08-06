//
//  HistoryRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import ChallengeHistoryScene
import SafariServices
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
        let challengeHistoryScene = ChallengeHistorySceneFactory().make(
            with: .init(challengeID: model.id)
        )
        let challengeHistoryViewController = challengeHistoryScene.viewController
        challengeHistoryViewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(challengeHistoryViewController, animated: true)
    }
    
    func routeToManualScene() {
        guard let url = URL(string: "https://two2too2.github.io/") else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        
        self.viewController?.present(safariViewController, animated: true, completion: nil)
    }
    
}
