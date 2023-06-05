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

public class NetworkManager {
    public static let shared = NetworkManager()
    
    public var connectionSubject = CurrentValueSubject<NetworkConnectionStatus, Never>(.offline)
    
    public var isConnectedToInternet: Bool {
        self.connectionSubject.value == .cellular ||
        self.connectionSubject.value == .wifi ||
        self.reachability?.connection ?? .unavailable != .unavailable
    }
    
    private let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    private let maxWaitTime = 15.0
    
    private let baseURL = ""
    
    private var reachability: Reachability? = nil
    
    public init() {
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
    
    public func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        additionalHeaders: HTTPHeaders? = nil
    ) async throws -> T {
        guard self.isConnectedToInternet else {
            throw NSError(domain: "no_internet_connection", code: -1)
        }
        
        var headers = self.headers
        additionalHeaders?.forEach { headers.add($0) }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                self.baseURL + path,
                method: method,
                parameters: parameters,
                headers: headers,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
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
        
        var headers = self.headers
        additionalHeaders?.forEach { headers.add($0) }
        
        return try await withCheckedThrowingContinuation { continuation in
            AF.upload(
                multipartFormData: { multipartFormData in
                    multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
                },
                to: self.baseURL + path,
                headers: headers,
                requestModifier: { $0.timeoutInterval = self.maxWaitTime }
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
