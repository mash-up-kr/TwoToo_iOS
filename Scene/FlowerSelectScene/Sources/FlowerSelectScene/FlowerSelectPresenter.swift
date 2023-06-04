//
//  FlowerSelectPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol FlowerSelectPresentationLogic {}

final class FlowerSelectPresenter {
    weak var viewController: FlowerSelectDisplayLogic?
    
}

// MARK: - Presentation Logic

extension FlowerSelectPresenter: FlowerSelectPresentationLogic {
    
}
