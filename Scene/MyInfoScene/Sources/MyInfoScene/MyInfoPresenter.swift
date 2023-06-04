//
//  MyInfoPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol MyInfoPresentationLogic {}

final class MyInfoPresenter {
    weak var viewController: MyInfoDisplayLogic?
    
}

// MARK: - Presentation Logic

extension MyInfoPresenter: MyInfoPresentationLogic {
    
}
