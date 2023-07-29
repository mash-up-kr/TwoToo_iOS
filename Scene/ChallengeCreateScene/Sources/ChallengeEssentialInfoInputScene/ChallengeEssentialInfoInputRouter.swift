//
//  ChallengeEssentialInfoInputRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import ChallengeAdditionalInfoInputScene
import ChallengeRecommendScene

// 다음화면
@MainActor
protocol ChallengeEssentialInfoInputRoutingLogic {
    /// 추가 입력 화면으로 이동한다.
    func routeToAdditionalInfoScene()
    /// 챌린지 추천 바텀시트 화면으로 이동한다.
    func routeToChallengeRecommendationScene()
}

final class ChallengeEssentialInfoInputRouter {
    weak var viewController: ChallengeEssentialInfoInputViewController?
    weak var dataStore: ChallengeEssentialInfoInputDataStore?
}

extension ChallengeEssentialInfoInputRouter: ChallengeEssentialInfoInputRoutingLogic {
    func routeToAdditionalInfoScene() {
        guard let challengeName = self.dataStore?.nameDataSource,
              let challengeStartDate = self.dataStore?.startDateDataSource,
              let challengeEndDate = self.dataStore?.endDateDataSource else { return }

        let challengeAdditionalInfoInputScene = ChallengeAdditionalInfoInputSceneFactory().make(
            with: .init(challengeName: challengeName,
                        challengeStartDate: challengeStartDate,
                        challengeEndDate: challengeEndDate)
        )

        let challengeAdditionalInfoInputViewController = challengeAdditionalInfoInputScene.viewController

        challengeAdditionalInfoInputViewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(challengeAdditionalInfoInputViewController, animated: true)
    }
    
    func routeToChallengeRecommendationScene() {
        guard let challengeName = self.dataStore?.didTriggerSelectChallengeName else { return }

        let challengeRecommendationScene = ChallengeRecommendSceneFactory().make(with: .init(didTriggerSelectChallengeName: challengeName)).bottomSheetViewController

        self.viewController?.present(challengeRecommendationScene, animated: true)
    }
}
