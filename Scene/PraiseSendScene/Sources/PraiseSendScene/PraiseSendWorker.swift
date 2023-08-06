//
//  PraiseSendWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit
import Foundation

protocol PraiseSendWorkerProtocol {
    /// 칭찬하기 요청
    func requestPraise(certificateID: String, praiseComment: String) async throws
}

final class PraiseSendWorker: PraiseSendWorkerProtocol {
    
    var commentNetworkWorker: CommentNetworkWorkerProtocol
    
    init(commentNetworkWorker: CommentNetworkWorkerProtocol) {
        self.commentNetworkWorker = commentNetworkWorker
    }
    
    func requestPraise(certificateID: String, praiseComment: String) async throws {
        guard let commitNo = Int(certificateID) else {
            throw NSError(domain: "not fount commit", code: -1)
        }
        _ = try await self.commentNetworkWorker.requestCommentSend(
            commitNo: commitNo,
            comment: praiseComment
        )
    }
}
