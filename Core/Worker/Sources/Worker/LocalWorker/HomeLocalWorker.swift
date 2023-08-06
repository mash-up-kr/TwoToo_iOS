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
    
    private let lastChallengeCompletedConfirmedDateKey: String = "lastChallengeCompletedConfirmedDate"
    private let lastBothCertificationConfirmedKey: String = "lastBothCertificationConfirmed"
    
    public var challengeCompletedConfirmed: Bool? {
        get {
            let currentDateString = Date().dateToString(.yearMonthDay)
            if self.lastChallengeCompletedConfirmedDateString != currentDateString {
                self.localDataSource.save(value: false, key: self.challengeCompletedConfirmedKey)
                return false
            }
            return self.localDataSource.read(key: self.challengeCompletedConfirmedKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            if newValue {
                let currentDateString = Date().dateToString(.yearMonthDay)
                self.lastChallengeCompletedConfirmedDateString = currentDateString
            }
            self.localDataSource.save(value: newValue, key: self.challengeCompletedConfirmedKey)
        }
    }
    
    public var bothCertificationConfirmed: Bool? {
        get {
            let currentDateString = Date().dateToString(.yearMonthDay)
            if self.lastBothCertificationConfirmedDateString != currentDateString {
                self.localDataSource.save(value: false, key: self.bothCertificationConfirmedKey)
                return false
            }
            return self.localDataSource.read(key: self.bothCertificationConfirmedKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            if newValue {
                let currentDateString = Date().dateToString(.yearMonthDay)
                self.lastBothCertificationConfirmedDateString = currentDateString
            }
            self.localDataSource.save(value: newValue, key: self.bothCertificationConfirmedKey)
        }
    }
    
    private var lastChallengeCompletedConfirmedDateString: String? {
        get {
            return self.localDataSource.read(key: self.lastChallengeCompletedConfirmedDateKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource.save(value: newValue, key: self.lastChallengeCompletedConfirmedDateKey)
        }
    }
    
    private var lastBothCertificationConfirmedDateString: String? {
        get {
            return self.localDataSource.read(key: self.lastBothCertificationConfirmedKey)
        }
        set {
            guard let newValue = newValue else {
                return
            }
            self.localDataSource.save(value: newValue, key: self.lastBothCertificationConfirmedKey)
        }
    }
}
