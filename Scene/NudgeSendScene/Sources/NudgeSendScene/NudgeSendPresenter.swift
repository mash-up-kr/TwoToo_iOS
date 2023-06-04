//
//  NudgeSendPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol NudgeSendPresentationLogic {}

final class NudgeSendPresenter {
    weak var viewController: NudgeSendDisplayLogic?
    
}

// MARK: - Presentation Logic

extension NudgeSendPresenter: NudgeSendPresentationLogic {
    
}
