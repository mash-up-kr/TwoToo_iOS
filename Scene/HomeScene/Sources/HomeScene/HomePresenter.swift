//
//  HomePresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol HomePresentationLogic {}

final class HomePresenter {
    weak var viewController: HomeDisplayLogic?
    
}

// MARK: - Presentation Logic

extension HomePresenter: HomePresentationLogic {
    
}
