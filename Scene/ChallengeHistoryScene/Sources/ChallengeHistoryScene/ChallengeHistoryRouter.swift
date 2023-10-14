//
//  ChallengeHistoryRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import UIKit
import ChallengeCertificateScene
import ChallengeHistoryDetailScene

@MainActor
protocol ChallengeHistoryRoutingLogic {
    /// 인증하기 화면으로 이동한다.
    func routeToChallengeCertificateScene()
    /// 인증 상세 화면으로 이동한다.
    func routeToChallengeHistoryDetailScene(title: String,
                                            certificate: ChallengeHistory.Model.Certificate,
                                            nickname: String,
                                            partnerNickname: String)
    /// 화면을 닫는다.
    func dismiss()
}

final class ChallengeHistoryRouter {
    weak var viewController: ChallengeHistoryViewController?
    weak var dataStore: ChallengeHistoryDataStore?
}

extension ChallengeHistoryRouter: ChallengeHistoryRoutingLogic {
    func routeToChallengeHistoryDetailScene(title: String,
                                            certificate: ChallengeHistory.Model.Certificate,
                                            nickname: String,
                                            partnerNickname: String) {
        
        let fac = ChallengeHistoryDetailSceneFactory().make(with: .init(detail: .init(id: certificate.id,
                                                                                      challengeName: title,
                                                                                      certificateImageUrl: certificate.certificateImageUrl,
                                                                                      certificateComment: certificate.certificateComment,
                                                                                      certificateTime: certificate.certificateTime,
                                                                                      complimentComment: certificate.complimentComment),
                                                                        user: .init(myNickname: nickname, partnerNickname: partnerNickname)))
        let vc = fac.viewController
        vc.modalPresentationStyle = .fullScreen
        self.viewController?.present(vc, animated: true)
    }
    
    
    func routeToChallengeCertificateScene() {
        guard let dataStore = self.dataStore else {
            return
        }
        let challengeCertificateScene = ChallengeCertificateSceneFactory().make(
            with: .init(challengeID: dataStore.challenge?.id ?? "")
        )
        self.viewController?.present(challengeCertificateScene.bottomSheetViewController, animated: true)
    }
    
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
