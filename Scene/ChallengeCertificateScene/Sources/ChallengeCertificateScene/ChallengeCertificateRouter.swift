//
//  ChallengeCertificateRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeCertificateRoutingLogic {}

final class ChallengeCertificateRouter {
    weak var viewController: ChallengeCertificateViewController?
    weak var dataStore: ChallengeCertificateDataStore?
}

extension ChallengeCertificateRouter: ChallengeCertificateRoutingLogic {
    
}
