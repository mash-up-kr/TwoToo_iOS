//
//  InvitationWaitWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol InvitationWaitWorkerProtocol {
    /// 공유 링크
    var invitationLink: String? { get }
    /// 파트너 조회
    func inquiryPartner() async throws -> InvitationWait.Model.Partner?
}

final class InvitationWaitWorker: InvitationWaitWorkerProtocol {
    
    // TODO: UD에서 공유 링크를 꺼내오는 작업 필요
    var invitationLink: String? {
        return nil
    }
    
    // TODO: 파트너 조회 통신 구현
    func inquiryPartner() async throws -> InvitationWait.Model.Partner? {
        return nil
    }
}
