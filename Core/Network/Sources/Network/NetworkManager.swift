//
//  NetworkManager.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

@_exported import Alamofire
import Combine
import Foundation
import Reachability

/// `NetworkManager`는 애플리케이션 내에서 모든 네트워크 요청을 처리하는 클래스입니다.
///
/// 이 클래스는 Singleton 패턴을 사용하여, 애플리케이션 내에서 단 한번만 인스턴스화되고 재사용됩니다.
/// 이를 통해 앱 전체에서 네트워크 연결 상태를 관찰하고 일관된 네트워크 요청을 보낼 수 있습니다.
///
/// `request`와 `upload` 메소드는 비동기 방식으로 네트워크 요청을 수행하며, 이들은 각각 일반 요청과 파일 업로드를 처리합니다.
/// 이 메소드들은 제네릭 파라미터 `T`를 사용하여 요청의 응답을 해당 타입으로 디코딩합니다.
///
/// 또한 `NetworkManager`는 네트워크 연결 상태를 실시간으로 감지하며,
/// 이 정보는 `connectionSubject`를 통해 외부에서 구독할 수 있습니다. `isConnectedToInternet`를 통해 현재 네트워크 연결 상태를 확인할 수 있습니다.
///
/// 사용 예시:
/// ```swift
/// async {
///     do {
///         // 일반 API 요청
///         let response: MyResponseType = try await NetworkManager.shared.request(
///             path: "/api/path",
///             method: .get
///         )
///         print(response)
///
///         // 파일 업로드 요청
///         let data = myData  // Data 객체
///         let uploadResponse: MyResponseType = try await NetworkManager.shared.upload(
///             path: "/api/upload",
///             data: data,
///             fileName: "myFile",
///             mimeType: "application/octet-stream"
///         )
///         print(uploadResponse)
///     } catch {
///         print(error)
///     }
///
///     // 네트워크 연결 상태 구독
///     let cancellable = NetworkManager.shared.connectionSubject.sink { connectionStatus in
///         print(connectionStatus)
///     }
/// }
/// ```
public class NetworkManager {
    
    /// 네트워크 매니저의 싱글톤 인스턴스
    ///
    /// 사용 예시:
    /// ```swift
    /// let networkManager = NetworkManager.shared
    /// ```
    public static let shared = NetworkManager()
    
    /// 네트워크 상태값에 대한 스트림
    ///
    /// 사용 예시:
    /// ```swift
    /// NetworkManager.shared.connectionSubject
    ///     .sink { connectionStatus in
    ///         switch connectionStatus {
    ///             case .wifi:
    ///                 print("와이파이 연결됨")
    ///
    ///             case .cellular:
    ///                 print("셀룰러 연결됨")
    ///
    ///             case .offline:
    ///                 print("오프라인 전환됨")
    ///     }
    /// ```
    public var connectionSubject = CurrentValueSubject<NetworkConnectionStatus, Never>(.offline)
    
    /// 현재 인터넷에 연결되어 있는지의 여부
    ///
    /// 사용 예시:
    /// ```swift
    /// if NetworkManager.shared.isConnectedToInternet {
    ///     print("인터넷 연결되어 있음")
    /// } else {
    ///     print("인터넷 연결이 끊겨 있음")
    /// }
    /// ```
    public var isConnectedToInternet: Bool {
        self.connectionSubject.value == .cellular ||
        self.connectionSubject.value == .wifi ||
        self.reachability?.connection ?? .unavailable != .unavailable
    }
    
    private var configuration: NetworkConfiguration
    
    private var reachability: Reachability? = nil
    
    public init(configuration: NetworkConfiguration = .init()) {
        self.configuration = configuration
        
        do {
            self.reachability = try Reachability()
            
            self.reachability?.whenReachable = { reachability in
                switch reachability.connection {
                    case .wifi:
                        self.connectionSubject.send(.wifi)
                        
                    case .cellular:
                        self.connectionSubject.send(.cellular)
                        
                    default:
                        self.connectionSubject.send(.offline)
                }
            }
            
            self.reachability?.whenUnreachable = { _ in
                self.connectionSubject.send(.offline)
            }

            try self.reachability?.startNotifier()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    /// 기본 정보를 변경합니다
    public func updateConfiguration(_ configuration: NetworkConfiguration) {
        self.configuration = configuration
    }
    
    /// 주어진 정보를 바탕으로 API 요청을 수행하고 결과를 Decodable 형태로 반환
    ///
    /// - Parameters:
    ///   - path: API의 경로
    ///   - method: HTTP 메소드 (.get, .post 등)
    ///   - parameters: API 요청에 사용될 파라미터 (기본값은 nil)
    ///   - additionalHeaders: API 요청에 추가로 사용될 헤더 (기본값은 nil)
    ///
    /// - Returns: 요청 결과를 Decodable 형태로 변환한 객체
    ///
    /// 사용 예시:
    /// ```swift
    /// async {
    ///     do {
    ///         let response: MyResponseType = try await NetworkManager.shared.request(
    ///             path: "/api/path",
    ///             method: .get
    ///         )
    ///         print(response)
    ///     } catch {
    ///         print(error)
    ///     }
    /// }
    /// ```
    public func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        additionalHeaders: HTTPHeaders? = nil
    ) async throws -> T {
        guard self.isConnectedToInternet else {
            throw NSError(domain: "no_internet_connection", code: -1)
        }
        
        var headers = self.configuration.headers
        additionalHeaders?.forEach { headers.add($0) }
        
        print("--------------- Network Start ---------------")
        print(path)
        print(method.rawValue)
        print(parameters ?? [:])
        print(additionalHeaders ?? [:])
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                self.configuration.baseURL + path,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers,
                requestModifier: {
                    $0.timeoutInterval = self.configuration.maxWaitTime
                }
            )
            .responseData { response in
                switch(response.result) {
                    case let .success(data):
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print(json)
                        }
                        print("--------------- Network End ---------------")
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            continuation.resume(returning: decodedData)
                        }
                        catch {
                            continuation.resume(throwing: NSError(domain: "decode_error", code: -2))
                        }
                        
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// 주어진 정보를 바탕으로 파일을 업로드하고 결과를 Decodable 형태로 반환
    ///
    /// - Parameters:
    ///   - path: 업로드할 API의 경로
    ///   - data: 업로드할 파일 데이터
    ///   - fileName: 업로드할 파일의 이름
    ///   - mimeType: 업로드할 파일의 MIME 타입
    ///   - additionalHeaders: API 요청에 추가로 사용될 헤더 (기본값은 nil)
    ///
    /// - Returns: 업로드 결과를 Decodable 형태로 변환한 객체
    ///
    /// 사용 예시:
    /// ```swift
    /// async {
    ///     do {
    ///         let data = myData  // Data 객체
    ///         let response: MyResponseType = try await NetworkManager.shared.upload(
    ///             path: "/api/upload",
    ///             data: data,
    ///             fileName: "myFile",
    ///             mimeType: "application/octet-stream"
    ///         )
    ///         print(response)
    ///     } catch {
    ///         print(error)
    ///     }
    /// }
    /// ```
    public func upload<T: Decodable>(
        path: String,
        data: Data,
        fileName: String,
        mimeType: String,
        additionalHeaders: HTTPHeaders? = nil
    ) async throws -> T {
        guard self.isConnectedToInternet else {
            throw NSError(domain: "no_internet_connection", code: -1)
        }
        
        var headers = self.configuration.headers
        additionalHeaders?.forEach { headers.add($0) }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
                },
                to: self.configuration.baseURL + path,
                headers: headers,
                requestModifier: {
                    $0.timeoutInterval = self.configuration.maxWaitTime
                }
            )
            .responseData { response in
                switch(response.result) {
                    case let .success(data):
                        do {
                            let decodedData = try JSONDecoder().decode(T.self, from: data)
                            continuation.resume(returning: decodedData)
                        }
                        catch {
                            continuation.resume(throwing: NSError(domain: "decode_error", code: -2))
                        }
                        
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }
}
