//
//  ChallengeCreateFinishPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeCreateFinishPresentationLogic {}

final class ChallengeCreateFinishPresenter {
    weak var viewController: ChallengeCreateFinishDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeCreateFinishPresenter: ChallengeCreateFinishPresentationLogic {
    
}
