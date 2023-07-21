//
//  FlowerSelectPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol FlowerSelectPresentationLogic {
    /// 꽃 선택 화면을 보여준다.
    func presentFlowerSelect()
    /// 꽃 선택을 한다.
    func selectFlower()
    /// 챌린지 생성 오류를 보여준다.
    func presentCreateChallengeError(error: Error)
    /// 챌린지 시작 오류를 보여준다.
    func presentStartChallengeError(error: Error)
}

final class FlowerSelectPresenter {
    weak var viewController: FlowerSelectDisplayLogic?
    
}

// MARK: - Presentation Logic

extension FlowerSelectPresenter: FlowerSelectPresentationLogic {
    func presentFlowerSelect() {

    }

    func selectFlower() {

    }

    func presentCreateChallengeError(error: Error) {

    }

    func presentStartChallengeError(error: Error) {

    }

    
}
