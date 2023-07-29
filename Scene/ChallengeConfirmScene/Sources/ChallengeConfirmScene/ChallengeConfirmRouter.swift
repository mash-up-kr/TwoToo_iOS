//
//  ChallengeConfirmRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeConfirmRoutingLogic {
    /// 닫기
    func pop()
    
    /// 꽃 선택 화면으로 이동한다.
    func routeToFlowerSelectScene(status: ChallengeConfirm.Model.ConfirmStatus, info: ChallengeConfirm.Model.ChallengeInfo)
}

final class ChallengeConfirmRouter {
    weak var viewController: ChallengeConfirmViewController?
    weak var dataStore: ChallengeConfirmDataStore?
}

extension ChallengeConfirmRouter: ChallengeConfirmRoutingLogic {
    func pop() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToFlowerSelectScene(status: ChallengeConfirm.Model.ConfirmStatus, info: ChallengeConfirm.Model.ChallengeInfo) {
        
    }
}
