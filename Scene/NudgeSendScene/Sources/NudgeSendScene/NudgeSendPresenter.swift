//
//  NudgeSendPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol NudgeSendPresentationLogic {
    /// 남은 찌르기 횟수를 보여준다.
    func presentRemainingNudgeCount(remainingNudgeCount: Int)
    /// 보내기 버튼을 활성화하여 보여준다.
    func presentEnabledSend()
    /// 보내기 버튼을 비활성화하여 보여준다.
    func presentDisabledSend()
    /// 찌르기 성공을 보여준다.
    func presentNudgeSuccess()
    /// 찌르기 실패를 보여준다.
    func presentNudgeError(error: Error)
}

final class NudgeSendPresenter {
    weak var viewController: NudgeSendDisplayLogic?
    
}

// MARK: - Presentation Logic

extension NudgeSendPresenter: NudgeSendPresentationLogic {
    
    func presentRemainingNudgeCount(remainingNudgeCount: Int) {
        self.viewController?.displayTitle(viewModel: .init(
            text: "찌르기 문구 보내기 (\(remainingNudgeCount)/3)"
        ))
    }
    
    func presentEnabledSend() {
        self.viewController?.displayNudgeButton(viewModel: .init(isEnabled: true))
    }
    
    func presentDisabledSend() {
        self.viewController?.displayNudgeButton(viewModel: .init(isEnabled: false))
    }
    
    func presentNudgeSuccess() {
        self.viewController?.displayToast(viewModel: .init(message: "짝꿍에게 찌르기 문구가 보내졌습니다 "))
    }
    
    func presentNudgeError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: "찌르기에 실패하였습니다. 다시 시도해주세요."))
    }
}
