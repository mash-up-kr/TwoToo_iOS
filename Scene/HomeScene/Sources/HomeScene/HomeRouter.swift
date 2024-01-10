//
//  HomeRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import NudgeSendScene
import ChallengeCertificateScene
import ChallengeHistoryScene
import ChallengeHistoryDetailScene
import ChallengeEssentialInfoInputScene
import ChallengeConfirmScene
import SafariServices
import UIKit

@MainActor
protocol HomeRoutingLogic {
    /// 챌린지 기본 정보 화면으로 이동한다.
    func routeToChallengeEssentialInfoInputScene()
    /// 챌린지 정보 확인 화면으로 이동한다.
    func routeToChallengeConfirmScene(entryPoint: String)
    /// 상대방 챌린지 히스토리 디테일 화면으로 이동한다.
    func routeToPartnerHistoryDetailScene(title: String, certificate: Home.Model.Certificate, nickname: String, partnerNickname: String)
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
        let challengeEssentialInfoInputScene = ChallengeEssentialInfoInputSceneFactory().make(with: .init())
        let challengeEssentialInfoInputViewController = challengeEssentialInfoInputScene.viewController
        challengeEssentialInfoInputViewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(challengeEssentialInfoInputViewController, animated: true)
    }
    
    func routeToChallengeConfirmScene(entryPoint: String) {
        guard let dataStore = self.dataStore else {
            return
        }
        let challengeConfirmScene = ChallengeConfirmSceneFactory().make(with: .init(
            challengeName: dataStore.challenge?.name ?? "",
            challengeStartDate: dataStore.challenge?.startDate?.dateToString(.shortYearMonthDay) ?? "",
            challengeEndDate: dataStore.challenge?.endDate?.dateToString(.shortYearMonthDay) ?? "",
            challengeRule: dataStore.challenge?.description ?? "",
            challengeID: dataStore.challenge?.id,
            didEnterStatus: entryPoint
        ))
        let challengeConfirmViewController = challengeConfirmScene.viewController
        challengeConfirmViewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(challengeConfirmViewController, animated: true)
    }
    
  
    // TODO: - 값 넣어줘야함
    func routeToPartnerHistoryDetailScene(title: String,
                                          certificate: Home.Model.Certificate,
                                          nickname: String,
                                          partnerNickname: String) {
      guard let dataStore = self.dataStore else {
          return
      }
      
      let historyDetailScene = ChallengeHistoryDetailSceneFactory().make(with: .init(
        detail: .init(
          id: certificate.id,
          challengeName: dataStore.challenge?.name ?? "",
          certificateImageUrl: "",
          certificateComment: "",
          certificateTime: Date(),
          complimentComment: ""
        ), user: .init(
          myNickname: dataStore.challenge?.myInfo.nickname ?? "",
          partnerNickname: dataStore.challenge?.partnerInfo.nickname ?? "",
          isMyHistoryDetail: false
        )
      ))
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
        guard let dataStore = self.dataStore else {
            return
        }
        let challengeHistoryScene = ChallengeHistorySceneFactory().make(
            with: .init(challengeID: dataStore.challenge?.id ?? "")
        )
        let challengeHistoryViewController = challengeHistoryScene.viewController
        challengeHistoryViewController.hidesBottomBarWhenPushed = true
        self.viewController?.navigationController?.pushViewController(challengeHistoryViewController, animated: true)
    }
    
    func routeToGuideScene() {
        guard let url = URL(string: "https://two2too2.github.io/") else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        
        self.viewController?.present(safariViewController, animated: true, completion: nil)
    }
}
