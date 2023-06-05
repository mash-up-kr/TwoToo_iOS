//
//  NetworkConfiguration.swift
//  
//
//  Created by 박건우 on 2023/06/05.
//

import Foundation

public struct NetworkConfiguration {
    /// 기본 헤더
    public let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    /// 기본 URL
    public let baseURL: String = ""
    /// 타임아웃 시간
    public let maxWaitTime: Double = 15.0
    
    public init() {}
}
