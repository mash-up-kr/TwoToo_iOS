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
        
    }
    
    func presentEnabledSend() {
        
    }
    
    func presentDisabledSend() {
        
    }
    
    func presentNudgeSuccess() {
        
    }
    
    func presentNudgeError(error: Error) {
        
    }
}
