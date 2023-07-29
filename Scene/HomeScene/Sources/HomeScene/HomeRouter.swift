//
//  HomeRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import NudgeSendScene
import PraiseSendScene
import ChallengeCertificateScene
import UIKit

@MainActor
protocol HomeRoutingLogic {
    /// 챌린지 기본 정보 화면으로 이동한다.
    func routeToChallengeEssentialInfoInputScene()
    /// 챌린지 정보 확인 화면으로 이동한다.
    func routeToChallengeConfirmScene(entryPoint: String)
    /// 칭찬하기 화면으로 이동한다.
    func routeToPraiseSendScene()
    /// 인증하기 화면으로 이동한다.
    func routeToChallengeCertificateScene()
    /// 찌르기 화면으로 이동한다.
    func routeToNudgeSendScene()
    /// 챌린지 히스토리 화면으로 이동한다.
    func routeToChallengeHistoryScene()
    /// 설명서 화면으로 이동한다.
    func routeToGuideScene()
}

final class HomeRouter {
    weak var viewController: HomeViewController?
    weak var dataStore: HomeDataStore?
}

extension HomeRouter: HomeRoutingLogic {
    
    func routeToChallengeEssentialInfoInputScene() {
        
    }
    
    func routeToChallengeConfirmScene(entryPoint: String) {
        
    }
    
    func routeToPraiseSendScene() {
        guard let dataStore = self.dataStore else {
            return
        }
        let praiseSendScene = PraiseSendSceneFactory().make(
            with: .init(certificateID: dataStore.challenge?.partnerInfo.todayCert?.id ?? "")
        )
        self.viewController?.present(praiseSendScene.bottomSheetViewController, animated: true)
    }
    
    func routeToChallengeCertificateScene() {
        guard let dataStore = self.dataStore else {
            return
        }
        let challengeCertificateScene = ChallengeCertificateSceneFactory().make(
            with: .init(challengeID: "1")
        )
        self.viewController?.present(challengeCertificateScene.bottomSheetViewController, animated: true)
    }
    
    func routeToNudgeSendScene() {
        guard let dataStore = self.dataStore else {
            return
        }
        let nudgeSendScene = NudgeSendSceneFactory().make(
            with: .init(remainingNudgeCount: dataStore.challenge?.stickRemaining ?? 5)
        )
        self.viewController?.present(nudgeSendScene.bottomSheetViewController, animated: true)
    }
    
    func routeToChallengeHistoryScene() {
        
    }
    
    func routeToGuideScene() {
        
    }
}
