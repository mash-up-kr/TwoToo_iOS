//
//  LoginPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

@MainActor
protocol LoginPresentationLogic {
    /// 온보딩을 보여준다.
    func presentOnboarding()
    /// 로그인을 보여준다.
    func presentLogin()
    /// 카카오 로그인 오류를 보여준다.
    func presentKakaoLoginError(error: Error)
    /// 애플 로그인 오류를 보여준다.
    func presentAppleLoginError(error: Error)
}

final class LoginPresenter {
    weak var viewController: LoginDisplayLogic?
    
}

// MARK: - Presentation Logic

extension LoginPresenter: LoginPresentationLogic {
    
    func presentOnboarding() {
        
    }
    
    func presentLogin() {
        
    }
    
    func presentKakaoLoginError(error: Error) {
        
    }
    
    func presentAppleLoginError(error: Error) {
        
    }
}
