//
//  ChallengeConfirmRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeConfirmRoutingLogic {}

final class ChallengeConfirmRouter {
    weak var viewController: ChallengeConfirmViewController?
    weak var dataStore: ChallengeConfirmDataStore?
}

extension ChallengeConfirmRouter: ChallengeConfirmRoutingLogic {
    
}
