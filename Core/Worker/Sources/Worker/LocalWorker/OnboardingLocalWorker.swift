//
//  OnboardingLocalWorker.swift
//  
//
//  Created by 박건우 on 2023/07/23.
//

import Foundation

public protocol OnboardingLocalWorkerProtocol {
    var isCheckedOnboarding: Bool? { get set }
}

public final class OnboardingLocalWorker: OnboardingLocalWorkerProtocol {
    
    var localDataSource: LocalDataSourceProtocol?
    
    public init(localDataSource: LocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    private let key: String = "isCheckedOnboarding"
    
    public var isCheckedOnboarding: Bool? {
        get {
            return self.localDataSource?.read(key: self.key)
        }
        set {
            self.localDataSource?.save(value: newValue, key: self.key)
        }
    }
}
