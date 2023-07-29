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
}

final class NicknameRegistPresenter {
    weak var viewController: NicknameRegistDisplayLogic?
    
}

// MARK: - Presentation Logic

extension NicknameRegistPresenter: NicknameRegistPresentationLogic {
    
    func presentInvitedUser(invitedUser: NicknameRegist.Model.InvitedUser) {
        let msg = "\(invitedUser.name)님의 짝꿍으로 초대가 되었습니다."
        self.viewController?.displayInvitedUser(viewModel: .init(
            inviteMessage: msg)
        )
    }
    
    func presentEnabledConfirmButton() {
        self.viewController?.displayConfirmButton(backgroundColor: .primary, isEnabled: true)
    }
    
    func presentDisabledConfirmButton() {
        self.viewController?.displayConfirmButton(backgroundColor: .grey400, isEnabled: false)
    }
    
    func presentNicknameError(error: Error) {
        self.viewController?.displayToast(viewModel: .init(message: "닉네임을 설정하던 중 오류가 발생하였습니다"))
    }
}
