//
//  InvitationLocalWorker.swift
//  
//
//  Created by 박건우 on 2023/07/24.
//

import Foundation

public protocol InvitationLocalWorkerProtocol {
    var isInvitationSend: Bool? { get set }
    var invitationLink: String? { get set }
}

public final class InvitationLocalWorker: InvitationLocalWorkerProtocol {
    
    var localDataSource: LocalDataSourceProtocol?
    
    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    private let isInvitationSendKey: String = "isInvitationSend"
    private let isInvitationLinkKey: String = "invitationLink"
    
    public var isInvitationSend: Bool? {
        get {
            return self.localDataSource?.read(key: self.isInvitationSendKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.isInvitationSendKey)
        }
    }
    
    public var invitationLink: String? {
        get {
            return self.localDataSource?.read(key: self.isInvitationLinkKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.isInvitationLinkKey)
        }
    }
}
