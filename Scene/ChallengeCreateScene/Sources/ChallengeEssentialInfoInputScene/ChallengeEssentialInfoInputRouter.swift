//
//  ChallengeEssentialInfoInputRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import ChallengeAdditionalInfoInputScene

// 다음화면
@MainActor
protocol ChallengeEssentialInfoInputRoutingLogic {
    func routeToAdditionalInfoScene()
}

final class ChallengeEssentialInfoInputRouter {
    weak var viewController: ChallengeEssentialInfoInputViewController?
    weak var dataStore: ChallengeEssentialInfoInputDataStore?
}

extension ChallengeEssentialInfoInputRouter: ChallengeEssentialInfoInputRoutingLogic {
    func routeToAdditionalInfoScene() {

        let challengeAdditionalInfoInputScene = ChallengeEssentialInfoInputSceneFactory().make(with: .init())

        let challengeAdditionalInfoInputViewController = challengeAdditionalInfoInputScene.viewController

        viewController?.navigationController?.pushViewController(challengeAdditionalInfoInputViewController, animated: true)

        

    }
}
