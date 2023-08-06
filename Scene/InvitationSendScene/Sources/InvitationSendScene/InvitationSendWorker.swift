//
//  InvitationSendWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import FirebaseDynamicLinks

protocol InvitationSendWorkerProtocol {
    /// 공유 링크 생성 요청
    func requestInvitationLinkCreate() async throws -> String
    /// 초대장 전송 여부
    var isInvitationSend: Bool { get set }
}

final class InvitationSendWorker: InvitationSendWorkerProtocol {
    
    var invitationLocalWorker: InvitationLocalWorkerProtocol
    var meLocalWorker: MeLocalWorkerProtocol
    
    init(
        invitationLocalWorker: InvitationLocalWorkerProtocol,
        meLocalWorker: MeLocalWorkerProtocol
    ) {
        self.invitationLocalWorker = invitationLocalWorker
        self.meLocalWorker = meLocalWorker
    }
    
    func requestInvitationLinkCreate() async throws -> String {
        let link = try await self.createInvitationLink()
        self.invitationLocalWorker.isInvitationSend = true
        self.invitationLocalWorker.invitationLink = link
        return link
    }
    
    var isInvitationSend: Bool {
        get {
            return self.invitationLocalWorker.isInvitationSend ?? false
        }
        set {
            self.invitationLocalWorker.isInvitationSend = newValue
        }
    }
    
    /// 내 유저 번호, 내 닉네임으로 동적 링크 생성
    ///
    /// https://twotoo.page.link/3mZvNUF1sUz8jLMk6
    private func createInvitationLink() async throws -> String {
        guard let link = URL(string: "https://twotoo.mashup.com/invite?userNo=\(self.meLocalWorker.userNo ?? 0)&nickname=\(self.meLocalWorker.nickname ?? "")".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""),
              let linkBuilder = DynamicLinkComponents(
                link: link,
                domainURIPrefix: "https://twotoo.page.link"
                    .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
              )
        else {
            throw NSError(domain: "create_invitation_link", code: -1)
        }

        linkBuilder.iOSParameters = DynamicLinkIOSParameters(bundleID: "kr.mash-up.TwoToo")
        linkBuilder.iOSParameters?.appStoreID = "6455260918"
        linkBuilder.iOSParameters?.customScheme = "kr.mash-up.TwoToo"

        linkBuilder.androidParameters = DynamicLinkAndroidParameters(packageName: "com.mashup.twotoo")
        linkBuilder.androidParameters?.minimumVersion = 1

        linkBuilder.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder.socialMetaTagParameters?.title = "TwoToo"
        linkBuilder.socialMetaTagParameters?.descriptionText = "투투에 진입합니다."
        linkBuilder.socialMetaTagParameters?.imageURL = URL(string: "")

        guard let longDynamicLink = linkBuilder.url else {
            throw NSError(domain: "create_invitation_link", code: -1)
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            DynamicLinkComponents.shortenURL(longDynamicLink, options: nil) { url, warnings, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                if let url = url?.absoluteString {
                    continuation.resume(returning: url)
                    return
                }
                continuation.resume(throwing: NSError(domain: "create_invitation_link", code: -1))
            }
        }
    }
}
