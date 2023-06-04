//
//  NicknameRegistPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol NicknameRegistPresentationLogic {}

final class NicknameRegistPresenter {
    weak var viewController: NicknameRegistDisplayLogic?
    
}

// MARK: - Presentation Logic

extension NicknameRegistPresenter: NicknameRegistPresentationLogic {
    
}
