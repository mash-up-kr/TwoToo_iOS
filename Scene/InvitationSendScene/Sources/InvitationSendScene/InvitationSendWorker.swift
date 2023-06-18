//
//  InvitationSendWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol InvitationSendWorkerProtocol {
    /// 공유 링크 생성 요청
    func requestInvitationLinkCreate() async throws -> String
    /// 초대장 전송 여부
    var isInvitationSend: Bool { get set }
}

final class InvitationSendWorker: InvitationSendWorkerProtocol {
    
    // TODO: Firebase Dynamic Link 활용
    // 생성 후 로컬에 저장
    func requestInvitationLinkCreate() async throws -> String {
        return ""
    }
    
    // TODO: UD에 값 저장 필요
    var isInvitationSend: Bool {
        get {
            return false
        }
        set {
            
        }
    }
}
