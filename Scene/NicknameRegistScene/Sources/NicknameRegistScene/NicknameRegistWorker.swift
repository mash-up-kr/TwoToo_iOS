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
    
    var localDataSource: LocalDataSourceProtocol
    var invitedUserLocalWorker: InvitedUserLocalWorker
    
    init(localDataSource: LocalDataSourceProtocol,
         invitedUserLocalWorker: InvitedUserLocalWorker) {
        self.localDataSource = localDataSource
        self.invitedUserLocalWorker = invitedUserLocalWorker
    }
    
    var invitedUser: NicknameRegist.Model.InvitedUser? {
        if let key = self.invitedUserLocalWorker.invitedUser,
            let user: String = self.localDataSource.read(key: key) {
            return NicknameRegist.Model.InvitedUser(name: user)
        } else {
            print("UserDefault에 유저 정보가 없습니다.")
            return nil
        }
    }
    
    // TODO: 닉네임을 설정하는 통신 필요
    func requestSetNickname(nickname: String) async throws {
        self.localDataSource.save(value: nickname, key: "invitedUser")
    }
    
    
    // TODO: 초대 유저로 매칭을 요청하는 통신 필요
    func requestMatching() async throws {
        
    }
}
