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
    func presentCalendar(startDate: ChallengeEssentialInfoInput.Model.Info.StartDate, endDate: ChallengeEssentialInfoInput.Model.Info.EndDate)
    /// 다음 버튼 활성화하여 보여준다.
    func presentEnabled(nextButton: ChallengeEssentialInfoInput.Model.Info.NextButton)
    /// 챌린지 이름을 보여준다.
    func presentChallengeName(model: ChallengeEssentialInfoInput.Model.Info.Name)
}

final class ChallengeEssentialInfoInputPresenter {
    weak var viewController: ChallengeEssentialInfoInputDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeEssentialInfoInputPresenter: ChallengeEssentialInfoInputPresentationLogic {
    func presentCalendar(startDate: ChallengeEssentialInfoInput.Model.Info.StartDate, endDate: ChallengeEssentialInfoInput.Model.Info.EndDate) {
        
        self.viewController?.displayCalendar(viewModel: .init(startDate: startDate.date, endDate: endDate.date))
    }

    func presentEnabled(nextButton: ChallengeEssentialInfoInput.Model.Info.NextButton) {

        self.viewController?.displaySetEnableNextButton(viewModel: .init(isEnabled: nextButton.isEnabled))
    }

    func presentChallengeName(model: ChallengeEssentialInfoInput.Model.Info.Name) {
        self.viewController?.displayChallengeName(viewModel: .init(text: model.text))
    }
}
