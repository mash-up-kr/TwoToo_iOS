//
//  InvitationLocalWorker.swift
//  
//
//  Created by 박건우 on 2023/07/24.
//

import Foundation

public protocol InvitationLocalWorkerProtocol {
    var isInvitationSend: Bool? { get set }
}

public final class InvitationLocalWorker: InvitationLocalWorkerProtocol {
    
    var localDataSource: LocalDataSourceProtocol?
    
    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    private let key: String = "isInvitationSend"
    
    public var isInvitationSend: Bool? {
        get {
            return self.localDataSource?.read(key: self.key)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.key)
        }
    }
}
