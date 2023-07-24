//
//  ChallengeAdditionalInfoInputRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeAdditionalInfoInputRoutingLogic {
    /// 뒤로 간다
    func pop()
    /// 챌린지 확인 화면으로 이동한다.
    func routeToChallengeConfirmScene()
}

final class ChallengeAdditionalInfoInputRouter {
    weak var viewController: ChallengeAdditionalInfoInputViewController?
    weak var dataStore: ChallengeAdditionalInfoInputDataStore?
}

extension ChallengeAdditionalInfoInputRouter: ChallengeAdditionalInfoInputRoutingLogic {

    func pop() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
    func routeToChallengeConfirmScene() {
        
    }
}
