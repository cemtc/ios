//
//  Storage.swift
//  FashionMix
//
//  Created by ayong on 2017/6/1.
//  Copyright © 2019年 ayong. All rights reserved.
//

import Foundation

final class StorageBase {
    struct Name {
        private(set)var rawValue: String
        
        init(_ rawValue: String) {
            self.rawValue = rawValue
        }
        
        init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
}

// MARK: - StorageBase
extension StorageBase {
    static func save(key: StorageBase.Name, value: Modelable) -> Void {
        UserDefaults.standard.set(value.properties(), forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    static func load(key: StorageBase.Name, className: Modelable.Type) -> Modelable? {
        if let properties = UserDefaults.standard.value(forKey: key.rawValue) as? Properties {
            return className.model(properties: properties)
        }
        return nil
    }
}

// MARK: - Any
extension StorageBase {
    static func save(key: StorageBase.Name, value: Any) -> Void {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    static func load(key: StorageBase.Name) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
}

// MARK: - String
extension StorageBase {
    static func string(key: StorageBase.Name) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    static func stringValue(key: StorageBase.Name) -> String {
        return UserDefaults.standard.string(forKey: key.rawValue) ?? ""
    }
}

// MARK: - Bool
extension StorageBase {
    static func bool(key: StorageBase.Name) -> Bool? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? Bool
    }
    static func boolValue(key: StorageBase.Name) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
}

// MARK: - Number
extension StorageBase {
    //Int
    static func int(key: StorageBase.Name) -> Int? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? Int
    }
    static func intValue(key: StorageBase.Name) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    //Double
    static func double(key: StorageBase.Name) -> Double? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? Double
    }
    static func doubleValue(key: StorageBase.Name) -> Double {
        return UserDefaults.standard.double(forKey: key.rawValue)
    }
    //Float
    static func float(key: StorageBase.Name) -> Float? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? Float
    }
    static func floatValue(key: StorageBase.Name) -> Float {
        return UserDefaults.standard.float(forKey: key.rawValue)
    }
}

