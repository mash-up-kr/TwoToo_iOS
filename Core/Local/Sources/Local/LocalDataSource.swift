//
//  LocalDataSource.swift
//  
//
//  Created by Julia on 2023/06/16.
//

import Foundation

public protocol LocalDataSourceProtocol {
    func save<T: Any> (value: T, key: String)
    func save(value: String, key: String)
    func save(value: Bool, key: String)
    func save(value: Int, key: String)
    
    func read<T: Any> (key: String) -> T?
    func read(key: String) -> String?
    func read(key: String) -> Bool?
    func read(key: String) -> Int?
    
    func remove(key: String)
}

public final class LocalDataSource: LocalDataSourceProtocol {
    
    public init() {}
    
    // MARK: - Save
    public func save<T: Any>(value: T, key: String) {
        print("UserDefault Save! \(key)")
        UserDefaults.standard.set(value, forKey: key)
    }
    
    public func save(value: String, key: String) {
        print("UserDefault Save! \(key)")
        UserDefaults.standard.set(value, forKey: key)
    }
    
    public func save(value: Bool, key: String) {
        print("UserDefault Save! \(key)")
        UserDefaults.standard.set(value, forKey: key)
    }
    
    public func save(value: Int, key: String) {
        print("UserDefault Save! \(key)")
        UserDefaults.standard.set(value, forKey: key)
    }
    
    // MARK: - Read
    public func read<T: Any>(key: String) -> T? {
        UserDefaults.standard.object(forKey: key) as? T
    }
        
    public func read(key: String) -> String? {
        UserDefaults.standard.string(forKey: key)
    }
        
    public func read(key: String) -> Bool? {
        UserDefaults.standard.bool(forKey: key)
    }
    
    public func read(key: String) -> Int? {
        UserDefaults.standard.integer(forKey: key)
    }
    
    // MARK: - Remove
    public func remove(key: String) {
        print("UserDefault Remove: \(key)")
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    public func removeAll() {
        print("UserDefault RemoveAll")
        UserDefaults.standard.dictionaryRepresentation().keys.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
