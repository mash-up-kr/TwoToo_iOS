//
//  FlowerSelectRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import ChallengeCreateFinishScene

@MainActor
protocol FlowerSelectRoutingLogic {
    /// 뒤로가기 버튼 클릭
    func pop()
    /// 챌린지 생성 완료 화면으로 이동
    func routeToChallengeCreateFinishScene()
}

final class FlowerSelectRouter {
    weak var viewController: FlowerSelectViewController?
    weak var dataStore: FlowerSelectDataStore?
}

extension FlowerSelectRouter: FlowerSelectRoutingLogic {

    func pop() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }

    func routeToChallengeCreateFinishScene() {
        let createFinishScene = ChallengeCreateFinishSceneFactory().make(with: .init())

        let createFinishViewController = createFinishScene.viewController

        self.viewController?.navigationController?.pushViewController(createFinishViewController, animated: true)
    }
}
