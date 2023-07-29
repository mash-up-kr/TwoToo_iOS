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
    /// 닉네임 설정 요청
    func requestSetNickname(nickname: String) async throws
    /// 매칭 요청
    func requestMatching() async throws
}

final class NicknameRegistWorker: NicknameRegistWorkerProtocol {
    
    var invitedUserWorker: InvitedUserLocalWorkerProtocol
        
    init(invitedUserLocalWorker: InvitedUserLocalWorkerProtocol) {
        self.invitedUserWorker = invitedUserLocalWorker
    }
    
    var invitedUser: NicknameRegist.Model.InvitedUser? {
        if let user: String = self.invitedUserWorker.invitedUser {
            return NicknameRegist.Model.InvitedUser(name: user)
        } else {
            print("UserDefault에 초대 받은 유저 정보가 없습니다.")
            return nil
        }
    }
    
    // TODO: 닉네임을 설정하는 통신 필요
    func requestSetNickname(nickname: String) async throws {

    }
    
    
    // TODO: 초대 유저로 매칭을 요청하는 통신 필요
    func requestMatching() async throws {
        
    }
}
