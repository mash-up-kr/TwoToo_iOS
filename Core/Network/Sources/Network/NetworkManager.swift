//
//  NetworkManager.swift
//  TwoToo
//
//  Created by 박건우 on 2023/06/04.
//  Copyright (c) 2023 TwoToo. All rights reserved.
//

@_exported import Alamofire
import Foundation

public class NetworkManager {
    public static let shared = NetworkManager()
    
    public init() {}
    
    private let headers: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    private let maxWaitTime = 15.0
    
    private let baseURL = ""
    
    public func request<T: Decodable>(
        path: String,
        method: HTTPMethod,
        parameters: Parameters? = nil,
        additionalHeaders: HTTPHeaders? = nil
    ) async throws -> T {
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
                            continuation.resume(throwing: NSError(domain: "decode_error", code: 100))
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
                            continuation.resume(throwing: NSError(domain: "decode_error", code: 100))
                        }
                        
                    case let .failure(error):
                        continuation.resume(throwing: error)
                }
            }
        }
    }
}
