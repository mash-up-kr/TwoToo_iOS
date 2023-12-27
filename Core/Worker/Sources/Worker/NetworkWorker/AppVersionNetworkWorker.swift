//
//  AppVersionNetworkWorker.swift
//
//
//  Created by Eddy on 2023/11/28.
//

import Foundation
import Network

public protocol AppVersionNetworkWorkerProtocol {
    func requestAppVersion() async throws -> Bool
}

/// 강제 업데이트 앱 버전 확인 Worker
public final class AppVersionNetworkWorker: AppVersionNetworkWorkerProtocol {
    
    public init() {}
    
    public func requestAppVersion() async throws -> Bool {
        guard let info = Bundle.main.infoDictionary,
              // 내 디바이스 현재 버전 가져오기
              let deviceAppVersion = info["CFBundleShortVersionString"] as? String,
              // 앱 번들아이디 가져오기
              let identifier = info["CFBundleIdentifier"] as? String,
              // 앱스토어 앱버전
              let url = URL(string: "http://itunes.apple.com/kr/lookup?bundleId=\(identifier)")
        else {
            return false
        }
        
        let data = try await URLSession.shared.data(from: url).0
        let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any]
        
        guard let result = (json?["results"] as? [Any])?.first as? [String: Any],
              let appStoreAppVersion = result["version"] as? String
        else {
            return false
        }
        return appStoreAppVersion > deviceAppVersion
    }
}
