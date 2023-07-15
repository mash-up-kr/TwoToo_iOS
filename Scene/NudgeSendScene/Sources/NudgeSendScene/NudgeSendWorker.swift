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
    
    func requestNudge(nudgeComment: String) async throws {
        
    }
}
