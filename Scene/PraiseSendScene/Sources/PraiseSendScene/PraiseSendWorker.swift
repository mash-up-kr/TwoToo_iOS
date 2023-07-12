//
//  PraiseSendWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol PraiseSendWorkerProtocol {
    /// 칭찬하기 요청
    func requestPraise(praiseComment: String) async throws
}

final class PraiseSendWorker: PraiseSendWorkerProtocol {
    
    func requestPraise(praiseComment: String) async throws {
        
    }
}
