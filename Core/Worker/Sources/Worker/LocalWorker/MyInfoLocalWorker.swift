//
//  MyInfoLocalWorker.swift
//  
//
//  Created by Eddy on 2023/08/06.
//

import Foundation

public protocol MyInfoLocalWorkerProtocol {
    var signOutRequestCompleted: Bool? { get set }
}

public final class MyInfoLocalWorker: MyInfoLocalWorkerProtocol {

    var localDataSource: LocalDataSourceProtocol?

    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }

    private let signOutRequestCompletedKey: String = "signOutRequestCompleted"

    public var signOutRequestCompleted: Bool? {
        get {
            return self.localDataSource?.read(key: self.signOutRequestCompletedKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource?.save(value: newValue, key: self.signOutRequestCompletedKey)
        }
    }
}
