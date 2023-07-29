//
//  MyInfoWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol MyInfoWorkerProtocol {
    /// 마이페이지 조회
    func fetchMypageInfo() async throws -> MyInfo.Model.Data
}

final class MyInfoWorker: MyInfoWorkerProtocol {
    // TODO: - API 요청 후 연동
    func fetchMypageInfo() async throws -> MyInfo.Model.Data {
        return  .init(myNickname: "왕", partnerNickname: "여왕", challengeTotalCount: "3")
    }
}
