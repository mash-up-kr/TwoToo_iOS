//
//  NetworkConfiguration.swift
//  
//
//  Created by 박건우 on 2023/06/05.
//

import Foundation

/// `NetworkConfiguration` 는 네트워크에 대한 기본 설정값을 가지고 있는 구조체입니다.
///
/// 이 구조체의 값을 변경함으로써 애플리케이션이 네트워크 요청을 할 때 기본적으로 세팅할 값을 수정할 수 있습니다.
public struct NetworkConfiguration {
    /// 기본 헤더
    public var headers: HTTPHeaders
    /// 기본 URL
    public var baseURL: String
    /// 타임아웃 시간
    public var maxWaitTime: Double
    
    public init(
        headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ],
        baseURL: String = "http://43.202.68.239:3000",
        maxWaitTime: Double = 15.0
    ) {
        self.headers = headers
        self.baseURL = baseURL
        self.maxWaitTime = maxWaitTime
    }
}
