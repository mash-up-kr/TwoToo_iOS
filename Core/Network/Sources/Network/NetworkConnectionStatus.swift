//
//  NetworkConnectionStatus.swift
//  
//
//  Created by 박건우 on 2023/06/05.
//

import Foundation

/// `NetworkConnectionStatus`는 네트워크 연결 상태를 나열한 열거형입니다.
///
/// 해당 상태를 이용하여 기기의 네트워크 상태를 분기할 수 있습니다.
public enum NetworkConnectionStatus {
    /// 셀룰러
    case cellular
    /// 와이파이
    case wifi
    /// 오프라인
    case offline
}
