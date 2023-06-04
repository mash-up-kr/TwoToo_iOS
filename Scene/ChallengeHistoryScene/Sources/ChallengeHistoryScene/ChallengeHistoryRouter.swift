//
//  ChallengeHistoryRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeHistoryRoutingLogic {}

final class ChallengeHistoryRouter {
    weak var viewController: ChallengeHistoryViewController?
    weak var dataStore: ChallengeHistoryDataStore?
}

extension ChallengeHistoryRouter: ChallengeHistoryRoutingLogic {
    
}
