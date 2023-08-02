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
}

final class MyInfoWorker: MyInfoWorkerProtocol {
    
    var meLocalWorker: MeLocalWorkerProtocol
    var meNetworkWorker: MeNetworkWorkerProtocol
    
    init(
        meLocalWorker: MeLocalWorkerProtocol,
        meNetworkWorker: MeNetworkWorkerProtocol
    ) {
        self.meLocalWorker = meLocalWorker
        self.meNetworkWorker = meNetworkWorker
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
}
