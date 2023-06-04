//
//  ChallengeAdditionalInfoInputPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeAdditionalInfoInputPresentationLogic {}

final class ChallengeAdditionalInfoInputPresenter {
    weak var viewController: ChallengeAdditionalInfoInputDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeAdditionalInfoInputPresenter: ChallengeAdditionalInfoInputPresentationLogic {
    
}
