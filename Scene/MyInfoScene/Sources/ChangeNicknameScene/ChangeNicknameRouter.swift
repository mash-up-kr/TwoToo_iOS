//
//  ChangeNicknameRouter.swift
//  TwoToo
//
//  Created by Eddy on 2023/10/12.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChangeNicknameRoutingLogic {
    // 화면을 닫는다.
    func dismiss()
}

final class ChangeNicknameRouter {
    weak var viewController: ChangeNicknameViewController?
    weak var dataStore: ChangeNicknameDataStore?
}

extension ChangeNicknameRouter: ChangeNicknameRoutingLogic {
    func dismiss() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
