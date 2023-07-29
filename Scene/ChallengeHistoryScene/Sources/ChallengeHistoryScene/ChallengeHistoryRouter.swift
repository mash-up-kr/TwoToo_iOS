//
//  ChallengeHistoryRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import ChallengeHistoryDetailScene

@MainActor
protocol ChallengeHistoryRoutingLogic {
    /// 인증하기 화면으로 이동한다.
    func routeToChallengeCertificateScene()
    /// 인증 상세 화면으로 이동한다.
    func routeToChallengeHistoryDetailScene(title: String,
                                            certificate: ChallengeHistory.Model.Certificate)
    /// 화면을 닫는다.
    func dismiss()
}

final class ChallengeHistoryRouter {
    weak var viewController: ChallengeHistoryViewController?
    weak var dataStore: ChallengeHistoryDataStore?
}

extension ChallengeHistoryRouter: ChallengeHistoryRoutingLogic {
    func routeToChallengeHistoryDetailScene(title: String,
                                            certificate: ChallengeHistory.Model.Certificate) {
//        print(">>>")
        let fac = ChallengeHistoryDetailSceneFactory().make(with: .init(detail: .init(id: certificate.id,
                                                                                      challengeName: title,
                                                                                      certificateImageUrl: certificate.certificateImageUrl,
                                                                                      certificateComment: certificate.certificateComment,
                                                                                      certificateTime: certificate.certificateTime,
                                                                                      complimentComment: certificate.complimentComment),
                                                                        user: .init(myNickname: "테스트공주", partnerNickname: "테스트왕자"))) // TODO: - 공통 worker에서 가져오기
        let vc = fac.viewController
        vc.modalPresentationStyle = .fullScreen
        self.viewController?.present(vc, animated: true)
    }
    
    
    func routeToChallengeCertificateScene() {
        
    }
    
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
