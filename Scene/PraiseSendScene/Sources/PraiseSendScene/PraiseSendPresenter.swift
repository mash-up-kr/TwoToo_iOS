//
//  PraiseSendPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol PraiseSendPresentationLogic {}

final class PraiseSendPresenter {
    weak var viewController: PraiseSendDisplayLogic?
    
}

// MARK: - Presentation Logic

extension PraiseSendPresenter: PraiseSendPresentationLogic {
    
}
