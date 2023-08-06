//
//  MyInfoLocalWorker.swift
//  
//
//  Created by Eddy on 2023/08/06.
//

import Foundation

public protocol MyInfoLocalWorkerProtocol {
    var kakaoSignOutRequestCompleted: Bool? { get set }
    var appleSignOutRequestCompleted: Bool? { get set }
}

public final class MyInfoLocalWorker: MyInfoLocalWorkerProtocol {

    var localDataSource: LocalDataSourceProtocol?

    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    private let kakaoSignOutRequestCompletedKey: String = "kakaoSignOutRequestCompleted"
    private let appleSignOutRequestCompletedKey: String = "appleSignOutRequestCompleted"
    
    public var kakaoSignOutRequestCompleted: Bool? {
        get {
            return self.localDataSource?.read(key: self.kakaoSignOutRequestCompletedKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.kakaoSignOutRequestCompletedKey)
        }
    }

    public var appleSignOutRequestCompleted: Bool? {
        get {
            return self.localDataSource?.read(key: self.appleSignOutRequestCompletedKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.appleSignOutRequestCompletedKey)
        }
    }
}
