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
    
    var invitedUserLocalWorker: InvitedUserLocalWorkerProtocol
    var invitationLocalWorker: InvitationLocalWorkerProtocol
    var meLocalWorker: MeLocalWorkerProtocol
    var partnerNetworkWorker: PartnerNetworkWorkerProtocol
    var nicknameNetworkWorker: NicknameNetworkWorkerProtocol
    
    init(
        invitedUserLocalWorker: InvitedUserLocalWorkerProtocol,
        invitationLocalWorker: InvitationLocalWorkerProtocol,
        meLocalWorker: MeLocalWorkerProtocol,
        partnerNetworkWorker: PartnerNetworkWorkerProtocol,
        nicknameNetworkWorker: NicknameNetworkWorkerProtocol
    ) {
        self.invitedUserLocalWorker = invitedUserLocalWorker
        self.invitationLocalWorker = invitationLocalWorker
        self.meLocalWorker = meLocalWorker
        self.partnerNetworkWorker = partnerNetworkWorker
        self.nicknameNetworkWorker = nicknameNetworkWorker
    }
    
    var invitationLink: String? {
        return self.invitationLocalWorker.invitationLink
    }
    
    var invitedPartnerNo: Int? {
        if let userNo: Int = self.invitedUserLocalWorker.invitedUserNo {
            if self.meLocalWorker.userNo == userNo {
                return nil
            }
            return userNo
        } else {
            return nil
        }
    }
    
    func inquiryPartner() async throws -> InvitationWait.Model.Partner? {
        let partnerResponse = try await self.partnerNetworkWorker.requestPartnerInquiry()
        
        if let partnerNo = partnerResponse.partnerNo {
            if partnerNo == 0 {
                guard let invitedPartnerNo = self.invitedPartnerNo,
                      let nickname = self.meLocalWorker.nickname else {
                    return nil
                }
                let nicknameResponse = try await self.nicknameNetworkWorker.requestNicknameRegist(
                    nickname: nickname,
                    partnerNo: invitedPartnerNo
                )
                self.meLocalWorker.nickname = nicknameResponse.nickname
                self.meLocalWorker.partnerNo = nicknameResponse.partnerNo
                return .init(id: String(invitedPartnerNo))
            }
            
            self.meLocalWorker.partnerNo = partnerNo
            return .init(id: String(partnerNo))
        }
        else {
            return nil
        }
    }
}
