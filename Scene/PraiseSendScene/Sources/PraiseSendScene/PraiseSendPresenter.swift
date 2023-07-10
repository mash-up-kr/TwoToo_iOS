//
//  PraiseSendPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol PraiseSendPresentationLogic {
    /// 보내기 버튼을 활성화하여 보여준다.
    func presentEnabledSend()
    /// 보내기 버튼을 비활성화하여 보여준다.
    func presentDisabledSend()
    /// 칭찬하기 성공을 보여준다.
    func presentPraiseSuccess()
    /// 칭찬하기 실패를 보여준다.
    func presentPraiseError(error: Error)
}

final class PraiseSendPresenter {
    weak var viewController: PraiseSendDisplayLogic?
    
}

// MARK: - Presentation Logic

extension PraiseSendPresenter: PraiseSendPresentationLogic {
    
    func presentEnabledSend() {
        
    }
    
    func presentDisabledSend() {
        
    }
    
    func presentPraiseSuccess() {
        
    }
    
    func presentPraiseError(error: Error) {
        
    }
}
