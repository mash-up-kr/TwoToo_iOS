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
    /// 옵션 팝업을 보여준다.
    func presentOptionPopup()
    /// 챌린지 그만두기 팝업을 보여준다.
    func presentQuitPopup()
    /// 챌린지 그만두기 팝업을 제거한다.
    func dismissQuitPopup()
    /// 챌린지 그만두기 성공을 보여준다.
    func presentChallengeQuitSuccess()
    /// 챌린지 그만두기 오류를 보여준다.
    func presentChallengeQuitError(error: Error)
}

final class ChallengeConfirmPresenter {
    weak var viewController: ChallengeConfirmDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChallengeConfirmPresenter: ChallengeConfirmPresentationLogic {

    func presentChallengeConfirmView(status: ChallengeConfirm.Model.ConfirmStatus, model: ChallengeConfirm.Model.ChallengeInfo) {
        
        let date = model.startDate + " ~ " + model.endDate
        
        switch status {
        case .create:
            self.viewController?.displayCreateView(info: .init(title: model.title, date: date, rule: model.rule))
        case .confirm:
            self.viewController?.displayConfirmView(info: .init(title: model.title, date: date, rule: model.rule))
        case .accept:
            self.viewController?.displayAcceptView(info: .init(title: model.title, date: date, rule: model.rule))
        }
    }

    func presentChallengeConfirmViewError(error: Error) {

    }
    
    func presentOptionPopup() {
        self.viewController?.displayOptionPopup(title: "챌린지 그만두기")
    }
    
    func presentQuitPopup() {
        let viewModel = ChallengeConfirm.ViewModel.QuitPopup(title: "챌린지 그만두기",
                                                             iconImage: .asset(.icon_delete)!,
                                                             description: "기존의 챌린지는 삭제 됩니다\n",
                                                             warning: "* (경고) 그만두기 시 양쪽 모두에게\n삭제 및 종료 됩니다!*",
                                                             buttonTitles: ["취소", "그만두기"])
        self.viewController?.displayQuitPopup(viewModel: viewModel)
    }
    
    func dismissQuitPopup() {
        self.viewController?.dismissQuitPopup()
    }
    
    func presentChallengeQuitSuccess() {
        self.viewController?.displayToast(message: "기존 챌린지를 삭제했어요. 새로운 챌린지를 도전하세요!")
    }
    
    func presentChallengeQuitError(error: Error) {
        self.viewController?.displayToast(message: error.localizedDescription)
    }
    
}
