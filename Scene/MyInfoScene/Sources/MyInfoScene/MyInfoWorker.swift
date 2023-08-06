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
    func fetchSocialLoginType() async throws -> MyInfo.Model.SocialLoginStatus
    /// 애플 로그인 재인증
    func retryAppleLogin()

    func setSignoutStatus(required: Bool)
    /// 회원탈퇴 요청 상태
    func fetchSignOutStatus() -> Bool
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

    func fetchSocialLoginType() async throws -> MyInfo.Model.SocialLoginStatus {

        switch self.meLocalWorker.socialType {
        case "Kakao":
            return .kakaoLogin
        case "Apple":
            return .appleLogin
        default:
            return .appleLogin
        }
    }

    func retryAppleLogin() {
        Task {
            try await appleLoginWorker.retryAppleLogin()
        }
    }

    func setSignoutStatus(required: Bool) {
        self.myInfoLocalWorker.signOutRequestCompleted = required
    }


    func fetchSignOutStatus() -> Bool {
        guard let requestCompletedStatus =  self.myInfoLocalWorker.signOutRequestCompleted else { return true}
        return requestCompletedStatus
    }
}
