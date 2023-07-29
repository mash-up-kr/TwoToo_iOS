//
//  HomeLocalWorker.swift
//  
//
//  Created by 박건우 on 2023/07/29.
//

import Foundation

public protocol HomeLocalWorkerProtocol {
    var challengeCompletedConfirmed: Bool? { get set }
    var bothCertificationConfirmed: Bool? { get set }
}

public final class HomeLocalWorker: HomeLocalWorkerProtocol {
    
    var localDataSource: LocalDataSourceProtocol
    
    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    private let challengeCompletedConfirmedKey: String = "challengeCompletedConfirmed"
    private let bothCertificationConfirmedKey: String = "bothCertificationConfirmed"
    
    public var challengeCompletedConfirmed: Bool? {
        get {
            return self.localDataSource.read(key: self.challengeCompletedConfirmedKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource.save(value: newValue, key: self.challengeCompletedConfirmedKey)
        }
    }
    
    public var bothCertificationConfirmed: Bool? {
        get {
            return self.localDataSource.read(key: self.bothCertificationConfirmedKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource.save(value: newValue, key: self.bothCertificationConfirmedKey)
        }
    }
}
