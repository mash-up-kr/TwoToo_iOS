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
    func presentCalendar(startDate: ChallengeEssentialInfoInput.Model.StartDate, endDate: ChallengeEssentialInfoInput.Model.EndDate)
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
    func presentCalendar(startDate: ChallengeEssentialInfoInput.Model.StartDate, endDate: ChallengeEssentialInfoInput.Model.EndDate) {
        self.viewController?.displayCalendar(viewModel: .init(startDate: startDate.date, endDate: endDate.date))
    }

    func presentEnabledNext() {



        self.viewController?.displaySetDisableNextButton(viewModel: .init(isEnabled: true))
    }

    func presentDisabledNext() {

        self.viewController?.displaySetDisableNextButton(viewModel: .init(isEnabled: false))
    }
}
