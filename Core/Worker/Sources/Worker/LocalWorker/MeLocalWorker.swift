//
//  MeLocalWorker.swift
//  
//
//  Created by 박건우 on 2023/07/24.
//

import Foundation
import Network

public protocol MeLocalWorkerProtocol {
    var token: String? { get set }
}

public final class MeLocalWorker: MeLocalWorkerProtocol {
    
    var localDataSource: LocalDataSourceProtocol?
    
    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    private let tokenKey: String = "token"
    
    public var token: String? {
        get {
            return self.localDataSource?.read(key: self.tokenKey)
        }
        set {
            var networkConfiguration = NetworkConfiguration()
            networkConfiguration.headers["bearer"] = newValue
            NetworkManager.shared.updateConfiguration(networkConfiguration)
            self.localDataSource?.save(value: newValue, key: self.tokenKey)
        }
    }
}
