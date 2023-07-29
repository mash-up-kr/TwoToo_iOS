//
//  FlowerSelectRouter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol FlowerSelectRoutingLogic {
    /// 뒤로가기 버튼 클릭
    func pop()
}

final class FlowerSelectRouter {
    weak var viewController: FlowerSelectViewController?
    weak var dataStore: FlowerSelectDataStore?
}

extension FlowerSelectRouter: FlowerSelectRoutingLogic {
    func pop() {
        
    }
}
