//
//  SplashWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol SplashWorkerProtocol {
    /// 유저 상태 조회
    func fetchUserState() async throws -> Splash.Model.UserState
}

final class SplashWorker: SplashWorkerProtocol {
    
    var meLocalWorker: MeLocalWorkerProtocol
    var invitationLocalWorker: InvitationLocalWorkerProtocol
    var meNetworkWorker: MeNetworkWorkerProtocol
    
    init(
        meLocalWorker: MeLocalWorkerProtocol,
        invitationLocalWorker: InvitationLocalWorkerProtocol,
        meNetworkWorker: MeNetworkWorkerProtocol
    ) {
        self.meLocalWorker = meLocalWorker
        self.invitationLocalWorker = invitationLocalWorker
        self.meNetworkWorker = meNetworkWorker
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
