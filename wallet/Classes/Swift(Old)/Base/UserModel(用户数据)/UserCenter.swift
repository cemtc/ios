//
//  UserCenter.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/7.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import SwiftyJSON

extension StorageBase.Name {
    static let loginer = StorageBase.Name.init(rawValue: "QYWalletLoginer")
}
class UserCenter: JSONParse {
    
    static let shared = StorageBase.load(key: StorageBase.Name.loginer, className: UserCenter.self) as? UserCenter ?? UserCenter.init()
    
    var isLogin: Bool? = false
    var pwdMD5 : String?
    var adress : String?
    var priviteKyey : String?
    var publicKyey : String?
    var mnemonic : String?
    var payPassword : String?
    init() {
    }
    
    /**
     * 用字典来初始化一个实例并设置各个属性值
     */
    init(fromDictionary dictionary: Dictionary<String, Any>){
        isLogin                 = dictionary["isLogin"] as? Bool
        pwdMD5                  = dictionary["pwdMD5"] as? String
        adress                  = dictionary["adress"] as? String
        priviteKyey             = dictionary["priviteKyey"] as? String
         publicKyey             = dictionary["publicKyey"] as? String
        mnemonic                = dictionary["mnemonic"] as? String
        payPassword             = dictionary["payPassword"] as? String
    }
    
    required convenience init(aJSON: JSON) {
        self.init(fromDictionary: aJSON.dictionaryObject ?? [:])
    }
    
    /**
     * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
     */
    func toDictionary() -> Dictionary<String, Any>
    {
        var dictionary = Dictionary<String, Any>()
        
        if isLogin != nil{
            dictionary["isLogin"] = isLogin
        }
        if pwdMD5 != nil {
            dictionary["pwdMD5"] = pwdMD5
        }
        if adress != nil {
            dictionary["adress"] = adress
        }
        if priviteKyey != nil {
            dictionary["priviteKyey"] = priviteKyey
        }
        if mnemonic != nil {
            dictionary["mnemonic"] = mnemonic
        }
        if payPassword != nil {
            dictionary["payPassword"] = payPassword
        }
        if publicKyey != nil {
            dictionary["publicKyey"] = publicKyey
        }
        return dictionary
    }
    
    func update(_ new: UserCenter, override: Bool = true) {
        if override {
            isLogin                 = new.isLogin
            pwdMD5                  = new.pwdMD5
            adress                  = new.adress
            priviteKyey             = new.priviteKyey
            mnemonic                = new.mnemonic
            payPassword             = new.payPassword
            publicKyey              = new.publicKyey
        }else{
            if new.isLogin != nil {
                isLogin                 = new.isLogin
            }
            
            if new.pwdMD5 != nil {
                pwdMD5                  = new.pwdMD5
            }
            if new.adress != nil {
                adress                  = new.adress
            }
            if new.mnemonic != nil {
                mnemonic                  = new.mnemonic
            }
            if new.priviteKyey != nil {
                priviteKyey                  = new.priviteKyey
            }
            if new.payPassword != nil {
                payPassword                  = new.payPassword
            }
            if new.publicKyey != nil {
                publicKyey                  = new.publicKyey
            }
        }
        
    }
    
    
    func saveSharedInstance() {
        StorageBase.save(key: StorageBase.Name.loginer, value: self)
    }
    
    
}
extension UserCenter: Modelable {
    func properties() -> Properties {
        return self.toDictionary()
    }
    
    static func model(properties: Properties) -> Modelable {
        return UserCenter.init(aJSON: JSON.init(properties))
    }
    
    
}

// MARK: - Logout
extension UserCenter {
    func reset() {
        isLogin                 = nil
        pwdMD5                  = nil
        adress                 = nil
        mnemonic                  = nil
        priviteKyey                 = nil
        payPassword                 = nil
        publicKyey             = nil
    }
}
