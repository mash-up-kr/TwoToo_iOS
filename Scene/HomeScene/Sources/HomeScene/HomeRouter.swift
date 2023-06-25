//
//  HomeRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

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

// TODO: 라우팅을 할때 dataStore 에 있는 챌린지 정보를 전달합니다.

extension HomeRouter: HomeRoutingLogic {
    
    func routeToChallengeEssentialInfoInputScene() {
        
    }
    
    func routeToChallengeConfirmScene(entryPoint: String) {
        
    }
    
    func routeToPraiseSendScene() {
        
    }
    
    func routeToChallengeCertificateScene() {
        
    }
    
    func routeToNudgeSendScene() {
        
    }
    
    func routeToChallengeHistoryScene() {
        
    }
    
    func routeToGuideScene() {
        
    }
}
