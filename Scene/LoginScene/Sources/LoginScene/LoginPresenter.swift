//
//  LoginPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol LoginPresentationLogic {}

final class LoginPresenter {
    weak var viewController: LoginDisplayLogic?
    
}

// MARK: - Presentation Logic

extension LoginPresenter: LoginPresentationLogic {
    
}
