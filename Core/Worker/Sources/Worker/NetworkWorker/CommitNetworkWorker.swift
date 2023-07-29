//
//  CommitNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/30.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/commit

public struct CommitResponse: Decodable {
    public var commitNo: Int
    public var userNo: Int
    public var challengeNo: Int
    public var text: String
    public var photoUrl: String
    public var partnerComment: String?
    public var createdAt: String
    public var updatedAt: String
}

public protocol CommitNetworkWorkerProtocol {
    func requestCommit(text: String, challengeNo: Int, img: Data, fileName: String) async throws -> CommitResponse
}

public final class CommitNetworkWorker: CommitNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestCommit(text: String, challengeNo: Int, img: Data, fileName: String) async throws -> CommitResponse {
        return try await NetworkManager.shared.upload(
            path: "/commit",
            data: img,
            fileName: fileName,
            mimeType: "image/jpeg",
            parameters: [
                "text": text,
                "challengeNo": String(challengeNo)
            ]
        )
    }
}
