//
//  ChallengeEssentialInfoInputRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeEssentialInfoInputRoutingLogic {}

final class ChallengeEssentialInfoInputRouter {
    weak var viewController: ChallengeEssentialInfoInputViewController?
    weak var dataStore: ChallengeEssentialInfoInputDataStore?
}

extension ChallengeEssentialInfoInputRouter: ChallengeEssentialInfoInputRoutingLogic {
    
}
