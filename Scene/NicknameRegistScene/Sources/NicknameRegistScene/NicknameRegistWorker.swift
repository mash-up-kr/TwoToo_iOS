//
//  NicknameRegistWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol NicknameRegistWorkerProtocol {
    /// 초대 유저
    var invitedUser: NicknameRegist.Model.InvitedUser? { get }
    /// 닉네임 설정 및 매칭
    /// Return:
    ///     - 파트너 매칭 여부
    func requestSetNicknameAndMatching(nickname: String) async throws -> Bool
}

final class NicknameRegistWorker: NicknameRegistWorkerProtocol {
    
    var invitedUserLocalWorker: InvitedUserLocalWorkerProtocol
    var meLocalWorker: MeLocalWorkerProtocol
    var nicknameNetworkWorker: NicknameNetworkWorkerProtocol
        
    init(
        invitedUserLocalWorker: InvitedUserLocalWorkerProtocol,
        meLocalWorker: MeLocalWorkerProtocol,
        nicknameNetworkWorker: NicknameNetworkWorkerProtocol
    ) {
        self.invitedUserLocalWorker = invitedUserLocalWorker
        self.meLocalWorker = meLocalWorker
        self.nicknameNetworkWorker = nicknameNetworkWorker
    }
    
    var invitedUser: NicknameRegist.Model.InvitedUser? {
        if let user: String = self.invitedUserLocalWorker.invitedUser,
           !user.isEmpty,
           let userNo: Int = self.invitedUserLocalWorker.invitedUserNo {
            if self.meLocalWorker.userNo == userNo {
                return nil
            }
            return NicknameRegist.Model.InvitedUser(no: userNo, name: user)
        } else {
            return nil
        }
    }
    
    func requestSetNicknameAndMatching(nickname: String) async throws -> Bool {
        let partnerNo = self.invitedUser?.no
        let nicknameResponse = try await self.nicknameNetworkWorker.requestNicknameRegist(
            nickname: nickname,
            partnerNo: partnerNo
        )
        self.meLocalWorker.nickname = nicknameResponse.nickname
        self.meLocalWorker.partnerNo = nicknameResponse.partnerNo
        
        if partnerNo == nil {
            return false
        }
        else {
            return true
        }
    }
}
