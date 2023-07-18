//
//  ChallengeEssentialInfoInputPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeEssentialInfoInputPresentationLogic {

    /// 캘린더 화면을 보여준다.
    func presentCalendar()
    /// 다음 버튼 활성화하여 보여준다.
    func presentEnabledNext()
    /// 다음 버튼 비활성화하여 보여준다.
    func presentDisabledNext()
}

final class ChallengeEssentialInfoInputPresenter {
    weak var viewController: ChallengeEssentialInfoInputDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeEssentialInfoInputPresenter: ChallengeEssentialInfoInputPresentationLogic {
    func presentCalendar() {

    }

    func presentEnabledNext() {

    }

    func presentDisabledNext() {

    }
}
