//
//  InvitedUserLocalWorker.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import Foundation

public protocol InvitedUserLocalWorkerProtocol {
    var invitedUser: String? { get set }
    var invitedUserNo: Int? { get set }
}

public final class InvitedUserLocalWorker: InvitedUserLocalWorkerProtocol {
    
    var localDataSource: LocalDataSourceProtocol?
    
    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    private let invitedUserKey: String = "invitedUser"
    private let invitedUserNoKey: String = "invitedUserNo"
    
    public var invitedUser: String? {
        get {
            return self.localDataSource?.read(key: self.invitedUserKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.invitedUserKey)
        }
    }
    
    public var invitedUserNo: Int? {
        get {
            return self.localDataSource?.read(key: self.invitedUserNoKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.invitedUserNoKey)
        }
    }
}
