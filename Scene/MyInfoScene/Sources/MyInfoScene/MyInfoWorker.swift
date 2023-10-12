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
    /// 회원탈퇴
    func signOut() async throws
}

final class MyInfoWorker: MyInfoWorkerProtocol {
    
    var meLocalWorker: MeLocalWorkerProtocol
    var meNetworkWorker: MeNetworkWorkerProtocol
    var signOutNetworkWorker: SignOutNetworkWorkerProtocol
    
    init(
        meLocalWorker: MeLocalWorkerProtocol,
        meNetworkWorker: MeNetworkWorkerProtocol,
        signOutNetworkWorker: SignOutNetworkWorkerProtocol
    ) {
        self.meLocalWorker = meLocalWorker
        self.meNetworkWorker = meNetworkWorker
        self.signOutNetworkWorker = signOutNetworkWorker
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

    func signOut() async throws {
        
        let signOutResponse = try await self.signOutNetworkWorker.requestSignOut()
        
        await self.logout()
    }
}
