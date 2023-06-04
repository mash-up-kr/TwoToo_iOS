//
//  ChallengeHistoryPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeHistoryPresentationLogic {}

final class ChallengeHistoryPresenter {
    weak var viewController: ChallengeHistoryDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeHistoryPresenter: ChallengeHistoryPresentationLogic {
    
}
