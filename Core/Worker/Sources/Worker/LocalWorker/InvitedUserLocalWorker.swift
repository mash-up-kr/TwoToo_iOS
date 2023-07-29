//
//  InvitedUserLocalWorker.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import Foundation

public protocol InvitedUserLocalWorkerProtocol {
    var invitedUser: String? { get set }
}

public final class InvitedUserLocalWorker: InvitedUserLocalWorkerProtocol {
    
    var localDataSource: LocalDataSourceProtocol?
    
    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    private let key: String = "invitedUser"
    
    public var invitedUser: String? {
        get {
            return self.localDataSource?.read(key: self.key)
        }
        set {
            self.localDataSource?.save(value: newValue, key: self.key)
        }
    }
}
