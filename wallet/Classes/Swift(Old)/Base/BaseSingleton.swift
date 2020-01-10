//
//  BaseSingleton.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/4/23.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import web3swift
//import Web3
import RealmSwift
public class BaseSingleton: NSObject {
 static let share = BaseSingleton()
    //用户数据类
    lazy var loginer: UserCenter = UserCenter.shared
    //web3创建
    //caofuqing --线上网络
     lazy var QYWeb3 = Web3.InfuraMainnetWeb3()
     //lazy var QYWeb3 =  Web3(rpcURL: "http://47.74.242.199:7575/")
    //lazy var QYWeb3 =  Web3(url: URL)
    //测试环境web caofuqing 没有测试成功
//    lazy var QYWeb3 = Web3.InfuraRopstenWeb3()

    
    lazy var realm = try! Realm(configuration:sharedConfiguration())

    var mnemonic : [String]?
    var pwdMD5 : String?
    var adress : String?
    var privateKey : String?
    var publicKey : String?
    //是否登录
    func randomArray(wordslist: Array<String>) -> Array<String> {
        var count = wordslist.count
        var temp = wordslist
        while count > 0 {
            let  index = arc4random_uniform(UInt32(count - 1));
            let value = temp[Int(index)]
            // 交换数组元素位置
            temp[Int(index)] = temp[count - 1];
            temp[count - 1] = value;
            count -= 1;
        }
        return temp
    }
    
    func save() {
        loginer.saveSharedInstance()
        //保存其他信息
    }
     func sharedConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        let directory = config.fileURL!.deletingLastPathComponent()
        let url = directory.appendingPathComponent("QYWallet.realm")
        return Realm.Configuration(fileURL: url)
    }
    ///MARK: 类型转换
    //将 Double 转为字符串
    func getStringFrom(double doubleVal: Double) -> String
    {
        var stringValue : String = "0.00"
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true;
        formatter.maximumSignificantDigits = 100
        formatter.groupingSeparator = "";
        formatter.numberStyle = .decimal
        stringValue = formatter.string(from: NSNumber(value: doubleVal))!;
        return stringValue
    }
    func getStringFrom(float floatleVal: Float) -> String
    {
        var stringValue : String = "0.00"
        
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true;
        formatter.maximumSignificantDigits = 100
        formatter.groupingSeparator = "";
        formatter.numberStyle = .decimal
        stringValue = formatter.string(from: NSNumber(value: floatleVal))!;
        return stringValue
    }
    
}
