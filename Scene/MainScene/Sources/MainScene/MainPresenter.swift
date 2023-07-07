//
//  MainPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol MainPresentationLogic {}

final class MainPresenter {
    weak var tabBarController: MainDisplayLogic?
    
}

// MARK: - Presentation Logic

extension MainPresenter: MainPresentationLogic {
    
}
