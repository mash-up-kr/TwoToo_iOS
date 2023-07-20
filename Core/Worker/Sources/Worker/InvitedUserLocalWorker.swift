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
    
    public init(localDataSource: LocalDataSourceProtocol = LocalDataSource()) {
        self.localDataSource = localDataSource
    }
    
    private let key: String = "invitedUser"
    
    public var invitedUser: String? {
        get {
            return self.localDataSource?.read(key: key)
        }
        set(user) {
            self.localDataSource?.save(value: user, key: key)
        }
    }
}
