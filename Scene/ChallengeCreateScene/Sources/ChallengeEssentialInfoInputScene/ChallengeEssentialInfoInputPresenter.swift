//
//  ChallengeEssentialInfoInputPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeEssentialInfoInputPresentationLogic {}

final class ChallengeEssentialInfoInputPresenter {
    weak var viewController: ChallengeEssentialInfoInputDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeEssentialInfoInputPresenter: ChallengeEssentialInfoInputPresentationLogic {
    
}
