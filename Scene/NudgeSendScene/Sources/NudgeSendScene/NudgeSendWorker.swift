//
//  NudgeSendWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol NudgeSendWorkerProtocol {
    /// 찌르기 요청
    func requestNudge(nudgeComment: String) async throws
}

final class NudgeSendWorker: NudgeSendWorkerProtocol {
    
    var stickNetworkWorker: StickNetworkWorkerProtocol
    
    init(stickNetworkWorker: StickNetworkWorkerProtocol) {
        self.stickNetworkWorker = stickNetworkWorker
    }
    
    func requestNudge(nudgeComment: String) async throws {
        _ = try await self.stickNetworkWorker.requestStick(message: nudgeComment)
    }
}
