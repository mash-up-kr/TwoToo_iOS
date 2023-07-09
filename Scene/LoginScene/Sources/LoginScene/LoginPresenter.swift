//
//  LoginPresenter.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import UIKit

import DesignSystem

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
        let onboardingItems: [Login.ViewModel.Onborading.Item] = [
            .init(image: .asset(.onboarding_1)!, text: "연인과 함께 달성할\n 목표를 세워보세요"),
            .init(image: .asset(.onboarding_2)!, text: "상대방에게 귀여운\n 찌르기로 푸시해보세요"),
            .init(image: .asset(.onboarding_3)!, text: "서로 인증 하고 응원하며\n 목표를 달성해보세요 ")
        ]

        viewController?.displayOnboarding(viewModel: .init(items: onboardingItems))

    }
    
    func presentLogin() {
        
    }
    
    func presentKakaoLoginError(error: Error) {
        
    }
    
    func presentAppleLoginError(error: Error) {
        
    }
}
