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
    var userNo: Int? { get set }
    var nickname: String? { get set }
    var partnerNo: Int? { get set }
    var partnerNickname: String? { get set }
    var deviceToken: String? { get set }
    var socialType: String? { get set }
}

public final class MeLocalWorker: MeLocalWorkerProtocol {
    
    var localDataSource: LocalDataSourceProtocol?
    
    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    private let tokenKey: String = "token"
    private let userNoKey: String = "userNo"
    private let nicknameKey: String = "nickname"
    private let partnerNoKey: String = "partnerNo"
    private let partnerNicknameKey: String = "partnerNickname"
    private let deviceTokenKey: String = "deviceToken"
    private let socialTypeKey: String = "socialType"
    
    public var token: String? {
        get {
            return self.localDataSource?.read(key: self.tokenKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            var networkConfiguration = NetworkConfiguration()
            networkConfiguration.headers["Authorization"] = "Bearer \(newValue)"
            NetworkManager.shared.updateConfiguration(networkConfiguration)
            self.localDataSource?.save(value: newValue, key: self.tokenKey)
        }
    }
    
    public var userNo: Int? {
        get {
            return self.localDataSource?.read(key: self.userNoKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.userNoKey)
        }
    }
    
    public var nickname: String? {
        get {
            return self.localDataSource?.read(key: self.nicknameKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.nicknameKey)
        }
    }
    
    public var partnerNo: Int? {
        get {
            return self.localDataSource?.read(key: self.partnerNoKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.partnerNoKey)
        }
    }
    
    public var partnerNickname: String? {
        get {
            return self.localDataSource?.read(key: self.partnerNicknameKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.partnerNicknameKey)
        }
    }
    
    public var deviceToken: String? {
        get {
            return self.localDataSource?.read(key: self.deviceTokenKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.deviceTokenKey)
        }
    }

    public var socialType: String? {
        get {
            return self.localDataSource?.read(key: self.socialTypeKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.socialTypeKey)
        }
    }
}
