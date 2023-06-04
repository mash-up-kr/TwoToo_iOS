//
//  ChallengeRecommendRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeRecommendRoutingLogic {}

final class ChallengeRecommendRouter {
    weak var viewController: ChallengeRecommendViewController?
    weak var dataStore: ChallengeRecommendDataStore?
}

extension ChallengeRecommendRouter: ChallengeRecommendRoutingLogic {
    
}
