//
//  LoginRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol LoginRoutingLogic {}

final class LoginRouter {
    weak var viewController: LoginViewController?
    weak var dataStore: LoginDataStore?
}

extension LoginRouter: LoginRoutingLogic {
    
}
