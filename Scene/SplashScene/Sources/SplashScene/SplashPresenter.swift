//
//  SplashPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol SplashPresentationLogic {}

final class SplashPresenter {
    weak var viewController: SplashDisplayLogic?
    
}

// MARK: - Presentation Logic

extension SplashPresenter: SplashPresentationLogic {
    
}
