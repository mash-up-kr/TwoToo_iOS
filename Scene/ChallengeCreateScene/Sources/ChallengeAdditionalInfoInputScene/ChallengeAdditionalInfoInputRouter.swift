//
//  ChallengeAdditionalInfoInputRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeAdditionalInfoInputRoutingLogic {}

final class ChallengeAdditionalInfoInputRouter {
    weak var viewController: ChallengeAdditionalInfoInputViewController?
    weak var dataStore: ChallengeAdditionalInfoInputDataStore?
}

extension ChallengeAdditionalInfoInputRouter: ChallengeAdditionalInfoInputRoutingLogic {
    
}
