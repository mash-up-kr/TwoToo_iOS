//
//  NicknameRegistPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol NicknameRegistPresentationLogic {
    /// 초대 유저를 보여준다.
    func presentInvitedUser(invitedUser: NicknameRegist.Model.InvitedUser)
    /// 확인 버튼을 활성화하여 보여준다.
    func presentEnabledConfirmButton()
    /// 확인 버튼을 비활성화하여 보여준다.
    func presentDisabledConfirmButton()
    /// 닉네임 설정 오류를 보여준다.
    func presentNicknameError(error: Error)
    /// 매칭 오류를 보여준다.
    func presentMatchingError(error: Error)
}

final class NicknameRegistPresenter {
    weak var viewController: NicknameRegistDisplayLogic?
    
}

// MARK: - Presentation Logic

extension NicknameRegistPresenter: NicknameRegistPresentationLogic {
    
    // TODO: ~~님의 짝꿍으로 초대가 되었다는 필드를 세팅해주어야함
    func presentInvitedUser(invitedUser: NicknameRegist.Model.InvitedUser) {
        
    }
    
    func presentEnabledConfirmButton() {
        
    }
    
    func presentDisabledConfirmButton() {
        
    }
    
    func presentNicknameError(error: Error) {
        
    }
    
    func presentMatchingError(error: Error) {
        
    }
}
