//
//  LoginWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol LoginWorkerProtocol {
    /// 온보딩 확인 여부
    var isCheckedOnboarding: Bool { get set }
    /// 카카오톡 설치 여부
    var isKakaoTalkAvailable: Bool { get }
    /// 카카오톡 로그인
    func loginWithKakaoTalk() async throws -> Login.Model.UserState
    /// 카카오 계정 로그인
    func loginWithKakaoAccount() async throws -> Login.Model.UserState
    /// 애플 로그인
    func loginWithApple() async throws -> Login.Model.UserState
}

final class LoginWorker: LoginWorkerProtocol {
    
    // TODO: UD 활용
    var isCheckedOnboarding: Bool {
        get {
            return false
        }
        set {
            
        }
    }
    
    // TODO: UserApi.isKakaoTalkLoginAvailable 활용 (KakaoOpenSDK)
    var isKakaoTalkAvailable: Bool {
        return false
    }
    
    // TODO: UserApi.shared.loginWithKakaoTalk 활용 (KakaoOpenSDK)
    func loginWithKakaoTalk() async throws -> Login.Model.UserState {
        return .nickname
    }
    
    // TODO: UserApi.shared.loginWithKakaoAccount 활용 (KakaoOpenSDK)
    func loginWithKakaoAccount() async throws -> Login.Model.UserState {
        return .nickname
    }
    
    // TODO: AuthenticationServices 활용
    func loginWithApple() async throws -> Login.Model.UserState {
        return .nickname
    }
}
