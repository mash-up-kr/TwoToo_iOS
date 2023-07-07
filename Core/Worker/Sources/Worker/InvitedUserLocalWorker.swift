//
//  InvitedUserLocalWorker.swift
//  
//
//  Created by Julia on 2023/07/07.
//

import Foundation

public final class InvitedUserLocalWorker {
    
    public init() { }
    
    var _invitedUser: String?
    
    public var invitedUser: String? {
        get {
            return self._invitedUser
        }
        set(user) {
            self._invitedUser = user
        }
    }
}
