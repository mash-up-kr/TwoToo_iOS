//
//  ChallengeCertificatePresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeCertificatePresentationLogic {}

final class ChallengeCertificatePresenter {
    weak var viewController: ChallengeCertificateDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeCertificatePresenter: ChallengeCertificatePresentationLogic {
    
}
