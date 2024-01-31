//
//  ChallengeHistoryDetailRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit
import PraiseSendScene

@MainActor
protocol ChallengeHistoryDetailRoutingLogic {
    /// 화면을 닫는다.
    func dismiss()
    /// 칭찬하기 화면으로 이동한다.
    func routeToPraiseSendScene()
}

final class ChallengeHistoryDetailRouter {
    weak var viewController: ChallengeHistoryDetailViewController?
    weak var dataStore: ChallengeHistoryDetailDataStore?
}

extension ChallengeHistoryDetailRouter: ChallengeHistoryDetailRoutingLogic {
    func dismiss() {
        self.viewController?.dismiss(animated: true)
    }
  
    func routeToPraiseSendScene() {
        guard let dataStore = self.dataStore else {
            return
        }
      
        let praiseSendScene = PraiseSendSceneFactory().make(
          with: .init(certificateID: dataStore.detail.id)
        )
        self.viewController?.present(praiseSendScene.bottomSheetViewController, animated: true)
    }
}
