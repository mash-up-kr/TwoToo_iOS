//
//  ChangeNicknameNetworkWorker.swift
//  
//
//  Created by Eddy on 2023/10/12.
//

import Foundation
import Network

public struct ChangeNicknameResponse: Decodable {
    public var nickname: String
}

public protocol ChangeNicknameNetworkWorkerProtocol {
    func requestChangeNicknameInquiry(nickname: String) async throws -> ChangeNicknameResponse
}

public final class ChangeNicknameNetworkWorker: ChangeNicknameNetworkWorkerProtocol {
    public init() {}
    
    public func requestChangeNicknameInquiry(nickname: String) async throws -> ChangeNicknameResponse {
        return try await NetworkManager.shared.request(
          path: "/user/changeNickname",
          method: .patch,
          parameters: [
            "nickname": nickname
          ]
        )
    }
}
