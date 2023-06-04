//
//  ChallengeHistoryDetailPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeHistoryDetailPresentationLogic {}

final class ChallengeHistoryDetailPresenter {
    weak var viewController: ChallengeHistoryDetailDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeHistoryDetailPresenter: ChallengeHistoryDetailPresentationLogic {
    
}
