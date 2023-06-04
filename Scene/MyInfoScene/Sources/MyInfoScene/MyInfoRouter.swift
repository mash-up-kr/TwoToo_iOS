//
//  MyInfoRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol MyInfoRoutingLogic {}

final class MyInfoRouter {
    weak var viewController: MyInfoViewController?
    weak var dataStore: MyInfoDataStore?
}

extension MyInfoRouter: MyInfoRoutingLogic {
    
}
