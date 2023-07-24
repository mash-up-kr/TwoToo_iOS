//
//  ChallengeConfirmPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChallengeConfirmPresentationLogic {
    /// 챌린지 확인 화면을 보여준다.
    func presentChallengeConfirmView(status: ChallengeConfirm.Model.ConfirmStatus, model: ChallengeConfirm.Model.ChallengeInfo)
    /// 챌린지 확인 에러 화면을 보여준다.
    func presentChallengeConfirmViewError(error: Error)
}

final class ChallengeConfirmPresenter {
    weak var viewController: ChallengeConfirmDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeConfirmPresenter: ChallengeConfirmPresentationLogic {

    func presentChallengeConfirmView(status: ChallengeConfirm.Model.ConfirmStatus, model: ChallengeConfirm.Model.ChallengeInfo) {
        switch status {
        case .create:
            self.viewController?.displayCreateView(info: .init(title: model.title, startDate: model.startDate, endDate: model.endDate, rule: model.rule))
        case .confirm:
            self.viewController?.displayConfirmView(info: .init(title: model.title, startDate: model.startDate, endDate: model.endDate, rule: model.rule))
        case .accept:
            self.viewController?.displayAcceptView(info: .init(title: model.title, startDate: model.startDate, endDate: model.endDate, rule: model.rule))
        }
    }

    func presentChallengeConfirmViewError(error: Error) {

    }
}
