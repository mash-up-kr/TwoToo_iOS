//
//  MyInfoWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol MyInfoWorkerProtocol {
    /// 마이페이지 조회
    func fetchMypageInfo() async throws -> MyInfo.Model.Data
    /// 로그아웃
    func logout() async
    /// 소셜로그인 타입 조회
    func fetchSocialLoginType() -> MyInfo.Model.SocialLoginStatus
    /// 애플 로그인 재인증
    func retryAppleLogin() async throws
    /// 회원탈퇴 요청 상태 세팅
    func setSignoutStatus(required: Bool, socialType: MyInfo.Model.SocialLoginStatus)
    /// 카카오 회원탈퇴 요청 상태
    func fetchKakaoSignOutStatus() -> Bool
    /// 애플 회원탈퇴 요청 상태
    func fetchAppleSignOutStatus() -> Bool
}

final class MyInfoWorker: MyInfoWorkerProtocol {

    var meLocalWorker: MeLocalWorkerProtocol
    var meNetworkWorker: MeNetworkWorkerProtocol
    var appleLoginWorker: AppleLoginWorkerProtocol
    var myInfoLocalWorker: MyInfoLocalWorkerProtocol
    
    init(
        meLocalWorker: MeLocalWorkerProtocol,
        meNetworkWorker: MeNetworkWorkerProtocol,
        appleLoginWorker: AppleLoginWorkerProtocol,
        myInfoLocalWorker: MyInfoLocalWorkerProtocol
    ) {
        self.meLocalWorker = meLocalWorker
        self.meNetworkWorker = meNetworkWorker
        self.appleLoginWorker = appleLoginWorker
        self.myInfoLocalWorker = myInfoLocalWorker
    }
    
    func fetchMypageInfo() async throws -> MyInfo.Model.Data {
        
        let mypageResponse = try await self.meNetworkWorker.requestMeInquiry()
        
        return  .init(
            myNickname: mypageResponse.nickname ?? "",
            partnerNickname: mypageResponse.partnerNickname ?? "",
            challengeTotalCount: String(mypageResponse.totalChallengeCount ?? 0)
        )
    }
    
    func logout() async {
        self.meLocalWorker.token = ""
    }

    func fetchSocialLoginType() -> MyInfo.Model.SocialLoginStatus {
        return .init(rawValue: self.meLocalWorker.socialType ?? "") ?? .appleLogin
    }

    func retryAppleLogin() async throws {
        _ = try await self.appleLoginWorker.retryAppleLogin()
    }

    func setSignoutStatus(required: Bool, socialType: MyInfo.Model.SocialLoginStatus) {
        switch socialType {
            case .kakaoLogin:
                self.myInfoLocalWorker.kakaoSignOutRequestCompleted = required
                
            case .appleLogin:
                self.myInfoLocalWorker.appleSignOutRequestCompleted = required
        }
    }
    
    func fetchKakaoSignOutStatus() -> Bool {
        guard let requestCompletedStatus = self.myInfoLocalWorker.kakaoSignOutRequestCompleted else { return true}
        return requestCompletedStatus
    }

    func fetchAppleSignOutStatus() -> Bool {
        guard let requestCompletedStatus = self.myInfoLocalWorker.appleSignOutRequestCompleted else { return true}
        return requestCompletedStatus
    }
}
