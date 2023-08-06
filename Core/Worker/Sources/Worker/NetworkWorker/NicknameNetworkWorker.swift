//
//  NicknameNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/29.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/user/nickname

public struct NicknameResponse: Decodable {
    public var userNo: Int
    public var nickname: String
    public var partnerNo: Int?
}

public protocol NicknameNetworkWorkerProtocol {
    func requestNicknameRegist(nickname: String, partnerNo: Int?) async throws -> NicknameResponse
}

public final class NicknameNetworkWorker: NicknameNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestNicknameRegist(nickname: String, partnerNo: Int?) async throws -> NicknameResponse {
        var parameters: Parameters = [:]
        if let partnerNo = partnerNo {
            parameters["partnerNo"] = partnerNo
        }
        parameters["nickname"] = nickname
        
        return try await NetworkManager.shared.request(
            path: "/user/nickname",
            method: .patch,
            parameters: parameters
        )
    }
}
