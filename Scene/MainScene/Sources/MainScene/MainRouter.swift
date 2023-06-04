//
//  MainRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol MainRoutingLogic {}

final class MainRouter {
    weak var viewController: MainViewController?
    weak var dataStore: MainDataStore?
}

extension MainRouter: MainRoutingLogic {
    
}
