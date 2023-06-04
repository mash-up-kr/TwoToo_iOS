//
//  HistoryRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol HistoryRoutingLogic {}

final class HistoryRouter {
    weak var viewController: HistoryViewController?
    weak var dataStore: HistoryDataStore?
}

extension HistoryRouter: HistoryRoutingLogic {
    
}
