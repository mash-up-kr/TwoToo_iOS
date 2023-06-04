//
//  ChallengeConfirmPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeConfirmPresentationLogic {}

final class ChallengeConfirmPresenter {
    weak var viewController: ChallengeConfirmDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeConfirmPresenter: ChallengeConfirmPresentationLogic {
    
}
