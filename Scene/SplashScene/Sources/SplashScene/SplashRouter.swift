//
//  SplashRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol SplashRoutingLogic {}

final class SplashRouter {
    weak var viewController: SplashViewController?
    weak var dataStore: SplashDataStore?
}

extension SplashRouter: SplashRoutingLogic {
    
}
