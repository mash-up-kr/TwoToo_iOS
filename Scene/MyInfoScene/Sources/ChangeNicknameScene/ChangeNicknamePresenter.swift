//
//  ChangeNicknamePresenter.swift
//  TwoToo
//
//  Created by Eddy on 2023/10/12.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol ChangeNicknamePresentationLogic {
  /// 닉네임 변경 성공을 보여준다
  func presentChangeNicknameSucess(text: String)
  /// 닉네임 변경 실패 오류를 보여준다.
  func presentChangeNicknameError(error: Error)
  /// 변경 버튼 활성화하여 보여준다.
  func presentEnabled(changeButton: ChangeNickname.ViewModel.ChangeButton)
}

final class ChangeNicknamePresenter {
    weak var viewController: ChangeNicknameViewControllerDisplayLogic?
    
}

// MARK: - Presentation Logic

extension ChangeNicknamePresenter: ChangeNicknamePresentationLogic {
  func presentChangeNicknameSucess(text: String) {
    self.viewController?.displayToast(viewModel: .init(message: text))
  }
  
  func presentChangeNicknameError(error: Error) {
    self.viewController?.displayToast(viewModel: .init(message: "닉네임 변경에 실패했습니다. 다시 시도해주세요"))
  }
  
  func presentEnabled(changeButton: ChangeNickname.ViewModel.ChangeButton) {
    self.viewController?.displaySetEnableNextButton(viewModel: .init(isEnabled: changeButton.isEnabled))
  }
}
