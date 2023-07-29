//
//  LoginWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser

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
    
    var onboardLocalWorker: OnboardingLocalWorkerProtocol
    var invitationLocalWorker: InvitationLocalWorkerProtocol
    var meLocalWorker: MeLocalWorkerProtocol
    var authNetworkWorker: AuthNetworkWorkerProtocol
    
    init(
        onboardLocalWorker: OnboardingLocalWorkerProtocol,
        invitationLocalWorker: InvitationLocalWorkerProtocol,
        meLocalWorker: MeLocalWorkerProtocol,
        authNetworkWorker: AuthNetworkWorkerProtocol
    ) {
        self.onboardLocalWorker = onboardLocalWorker
        self.invitationLocalWorker = invitationLocalWorker
        self.meLocalWorker = meLocalWorker
        self.authNetworkWorker = authNetworkWorker
    }
    
    var isCheckedOnboarding: Bool {
        get {
            return self.onboardLocalWorker.isCheckedOnboarding ?? false
        }
        set {
            self.onboardLocalWorker.isCheckedOnboarding = newValue
        }
    }
    
    var isKakaoTalkAvailable: Bool {
        return UserApi.isKakaoTalkLoginAvailable()
    }
    
    func loginWithKakaoTalk() async throws -> Login.Model.UserState {
        try await self.loginWithKakaoTalkSDK()
        let kakaoID = try await self.fetchKakaoID()
        return try await self.requestLogin(socialId: String(kakaoID), loginType: "Kakao")
    }
    
    func loginWithKakaoAccount() async throws -> Login.Model.UserState {
        try await self.loginWithKakaoAccountSDK()
        let kakaoID = try await self.fetchKakaoID()
        return try await self.requestLogin(socialId: String(kakaoID), loginType: "Kakao")
    }
    
    // TODO: AuthenticationServices 활용
    func loginWithApple() async throws -> Login.Model.UserState {
        return .nickname
    }
    
    private func requestLogin(socialId: String, loginType: String) async throws -> Login.Model.UserState {
        let authResponse = try await self.authNetworkWorker.requestAuthorize(
            socialId: socialId,
            loginType: loginType,
            deviceToken: self.meLocalWorker.deviceToken ?? ""
        )
        self.meLocalWorker.token = authResponse.accessToken
        self.meLocalWorker.nickname = authResponse.nickname
        self.meLocalWorker.userNo = authResponse.userNo
        self.meLocalWorker.partnerNo = authResponse.partnerNo
        switch authResponse.state {
            case "NEED_NICKNAME":
                return .nickname
                
            case "NEED_MATCHING":
                if self.invitationLocalWorker.isInvitationSend ?? false {
                    return .invitationWait
                }
                else {
                    return .invitationSend
                }
                
            case "HOME":
                return .home
                
            default:
                return .nickname
        }
    }
    
    @MainActor
    private func loginWithKakaoTalkSDK() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoTalk { oAuthToken, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        }
    }
    
    private func loginWithKakaoAccountSDK() async throws {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount { oAuthToken, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        }
    }
    
    private func fetchKakaoID() async throws -> Int64 {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.me { user, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let user = user,
                      let kaokaoID = user.id else {
                    continuation.resume(throwing: NSError(domain: "kakao_id", code: -1))
                    return
                }
                continuation.resume(returning: kaokaoID)
            }
        }
    }
}
