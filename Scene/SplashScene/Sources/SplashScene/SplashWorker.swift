//
//  SplashWorker.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/03.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

import CoreKit

protocol SplashWorkerProtocol {
    /// 유저 상태 조회
    func fetchUserState() async throws -> Splash.Model.UserState
}

final class SplashWorker: SplashWorkerProtocol {
    
    // TODO: 유저 상태에 따른 랜딩 플로우를 참고하여 작업 필요
    func fetchUserState() async throws -> Splash.Model.UserState {
        return .login
    }
}
