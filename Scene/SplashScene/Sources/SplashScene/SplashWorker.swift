//
//  SplashWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

protocol SplashWorkerProtocol {
    /// 유저 상태 조회
    func fetchUserState() async throws -> Splash.Model.UserState
    func checkAppVersion() async throws -> Bool
}

final class SplashWorker: SplashWorkerProtocol {
    
    var meLocalWorker: MeLocalWorkerProtocol
    var invitationLocalWorker: InvitationLocalWorkerProtocol
    var meNetworkWorker: MeNetworkWorkerProtocol
    var appVersionWorker: AppVersionNetworkWorkerProtocol
    
    init(
        meLocalWorker: MeLocalWorkerProtocol,
        invitationLocalWorker: InvitationLocalWorkerProtocol,
        meNetworkWorker: MeNetworkWorkerProtocol,
        appVersionWorker: AppVersionNetworkWorkerProtocol
    ) {
        self.meLocalWorker = meLocalWorker
        self.invitationLocalWorker = invitationLocalWorker
        self.meNetworkWorker = meNetworkWorker
        self.appVersionWorker = appVersionWorker
    }
    
    // 최신버전인지 아닌지 확인하는 함수
    func checkAppVersion() async throws -> Bool {
        return try await self.appVersionWorker.requestAppVersion()
    }
    
    func fetchUserState() async throws -> Splash.Model.UserState {
        guard let token = self.meLocalWorker.token else {
            return .login
        }
        self.meLocalWorker.token = token
        
        let meResponse = try await self.meNetworkWorker.requestMeInquiry()
        self.meLocalWorker.userNo = meResponse.userNo
        self.meLocalWorker.nickname = meResponse.nickname
        self.meLocalWorker.partnerNo = meResponse.partnerNo
        self.meLocalWorker.partnerNickname = meResponse.partnerNickname
        
        if meResponse.nickname == nil || meResponse.nickname?.isEmpty ?? true {
            return .nickname
        }
        
        if meResponse.partnerNickname == nil || meResponse.partnerNickname?.isEmpty ?? true {
            if !(self.invitationLocalWorker.isInvitationSend ?? false) {
                return .invitationSend
            }
            return .invitationWait
        }
        
        return .home
    }
}
