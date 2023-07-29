//
//  ChallengeHistoryRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeHistoryRoutingLogic {
    /// 인증하기 화면으로 이동한다.
    func routeToChallengeCertificateScene()
    /// 인증 상세 화면으로 이동한다.
    func routeToChallengeHistoryDetailScene(certificate: ChallengeHistory.Model.Certificate)
    /// 화면을 닫는다.
    func dismiss()
}

final class ChallengeHistoryRouter {
    weak var viewController: ChallengeHistoryViewController?
    weak var dataStore: ChallengeHistoryDataStore?
}

extension ChallengeHistoryRouter: ChallengeHistoryRoutingLogic {
    
    func routeToChallengeCertificateScene() {
        
    }
    
    func routeToChallengeHistoryDetailScene(certificate: ChallengeHistory.Model.Certificate) {
        
    }
    
    func dismiss() {
        
    }
}
