//
//  CommentNetworkWorker.swift
//  
//
//  Created by 박건우 on 2023/07/30.
//

import Foundation
import Network

// https://twotoo-node-zmtrd.run.goorm.site/commit/0/comment

public struct CommentResponse: Decodable {
    public var commitNo: Int
    public var userNo: Int
    public var challengeNo: Int
    public var text: String
    public var photoUrl: String
    public var partnerComment: String?
    public var createdAt: String
    public var updatedAt: String
}

public protocol CommentNetworkWorkerProtocol {
    func requestCommentSend(commitNo: Int, comment: String) async throws -> CommentResponse
}

public final class CommentNetworkWorker: CommentNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestCommentSend(commitNo: Int, comment: String) async throws -> CommentResponse {
        return try await NetworkManager.shared.request(
            path: "/commit/\(commitNo)/comment",
            method: .post,
            parameters: [
                "comment": comment
            ]
        )
    }
}
