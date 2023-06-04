//
//  HomeRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol HomeRoutingLogic {}

final class HomeRouter {
    weak var viewController: HomeViewController?
    weak var dataStore: HomeDataStore?
}

extension HomeRouter: HomeRoutingLogic {
    
}
