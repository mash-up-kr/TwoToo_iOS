//
//  PartnerNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/29.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/user/partner

public struct PartnerResponse: Decodable {
    public var partnerNo: Int?
}

public protocol PartnerNetworkWorkerProtocol {
    func requestPartnerInquiry() async throws -> PartnerResponse
}

public final class PartnerNetworkWorker: PartnerNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestPartnerInquiry() async throws -> PartnerResponse {
        return try await NetworkManager.shared.request(
            path: "/user/partner/",
            method: .get
        )
    }
}
