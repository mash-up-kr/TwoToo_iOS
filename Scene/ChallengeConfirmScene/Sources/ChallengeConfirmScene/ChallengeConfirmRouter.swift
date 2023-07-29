//
//  ChallengeConfirmRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import FlowerSelectScene

@MainActor
protocol ChallengeConfirmRoutingLogic {
    /// 닫기
    func pop()
    /// 꽃 선택 화면으로 이동한다.
    func routeToFlowerSelectScene()
}

final class ChallengeConfirmRouter {
    weak var viewController: ChallengeConfirmViewController?
    weak var dataStore: ChallengeConfirmDataStore?
}

extension ChallengeConfirmRouter: ChallengeConfirmRoutingLogic {
    func pop() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToFlowerSelectScene() {
        guard let challengeName = self.dataStore?.challengeName,
              let challengeStartDate = self.dataStore?.challengeStartDate,
              let challengeEndDate = self.dataStore?.challengeEndDate,
              let didEnterStatus = self.dataStore?.didEnterStatusDataSource

        else { return }

        let flowerSelectScene = FlowerSelectSceneFactory().make(with: .init(didTriggerChallengeCreateScene: .init(), didTriggerRouteToHomeScene: .init(), enterSceneStatus: didEnterStatus, challengeName: challengeName, challengeStartDate: challengeStartDate, challengeEndDate: challengeEndDate, challengeRule: self.dataStore?.challengeRule))

        let flowerSelectViewController = flowerSelectScene.viewController

        flowerSelectViewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(flowerSelectViewController, animated: true)
    }
}
