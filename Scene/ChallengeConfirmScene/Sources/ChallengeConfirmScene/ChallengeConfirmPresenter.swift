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
    func presentChallengeConfirmView(status: ChallengeConfirm.Model.ConfirmStatus)
    /// 챌린지 확인 에러 화면을 보여준다.
    func presentChallengeConfirmViewError(error: Error)
}

final class ChallengeConfirmPresenter {
    weak var viewController: ChallengeConfirmDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeConfirmPresenter: ChallengeConfirmPresentationLogic {

    func presentChallengeConfirmView(status: ChallengeConfirm.Model.ConfirmStatus) {
        switch status {
        case .create:
            self.viewController?.displayCreateView(info: .init(title: "하루 운동 30분 이상 하기", startDate: "23/05/01", endDate: "23/05/22", rule: "운동사진으로 인증하기\n실패하는 사람은 뷔폐 쏘기운동사진으로 인증하기운동사진으로 인증하기\n실패하는 사람은 뷔폐 쏘기운동사진으로 인증하기운동사진으로 인증하기\n실패하는 사람은 뷔폐 쏘기운동사진으로 인증하기"))
        case .confirm:
            self.viewController?.displayConfirmView(info: .init(title: "하루 운동 30분 이상 하기", startDate: "23/05/01", endDate: "23/05/22", rule: "운동사진으로 인증하기\n실패하는 사람은 뷔폐 "))
        case .accept:
            self.viewController?.displayAcceptView(info: .init(title: "하루 운동 30분 이상 하기", startDate: "23/05/01", endDate: "23/05/22"))
        }
    }

    func presentChallengeConfirmViewError(error: Error) {

    }
}
