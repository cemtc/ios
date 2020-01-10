//
//  TokendEtailModel.swift
//  wallet
//
//  Created by 曾云 on 2019/8/24.
//  Copyright © 2019 talking　. All rights reserved.
//

import UIKit
import SwiftyJSON


enum TokendEtailItemType:Int {
    case TokendEtailItemType_Transfer = 0 /**< 转账消息 */
    case TokendEtailItemType_Collection = 1 /**< 收款消息 */
}

class TokendEtailItemModel: NSObject {
    var blockHash: NSString = ""
    var blockNumbe: NSInteger = 0
    var contract: NSInteger = 0
    var cumulativeGasUsed :NSInteger = 0
    var from: NSString = ""
    var fromReadStatus: NSInteger = 0
    var gas: NSInteger = 0
    var gasPrice: NSInteger = 0
    var gasUsed: NSInteger = 0
    var hash_K: NSString = ""
    var input: NSString = ""
    var nonce: NSInteger = 0
    var realAddress: NSString = ""
    var realValue: String = ""
    var removed: Bool = false
    var status: NSString = ""
    var timestamp: NSInteger = 0
    var to: NSString = ""
    var toReadStatus: NSInteger = 0
    var tokenName: NSString = ""
    var topics: NSArray = []
    var transactionIndex: NSInteger = 0
    var v: Int64 = 0
    var value: NSString  = ""
    
    
    override init() {
        
    }
    init(jsonData: JSON) {
        blockHash = jsonData["blockHash"].stringValue as NSString
        blockNumbe = jsonData["blockNumbe"].intValue
        contract = jsonData["contract"].intValue
        cumulativeGasUsed = jsonData["cumulativeGasUsed"].intValue
        from = jsonData["from"].stringValue as NSString
        fromReadStatus = jsonData["fromReadStatus"].intValue
        gas = jsonData["gas"].intValue
        gasPrice = jsonData["gasPrice"].intValue
        gasUsed = jsonData["gasUsed"].intValue
        hash_K = jsonData["hash"].stringValue as NSString
        input = jsonData["input"].stringValue as NSString
        nonce = jsonData["nonce"].intValue
        realAddress = jsonData["realAddress"].stringValue as NSString
        realValue = jsonData["realValue"].stringValue
        removed = jsonData["removed"].boolValue
        status = jsonData["status"].stringValue as NSString
        timestamp = jsonData["timestamp"].intValue
        to = jsonData["to"].stringValue as NSString
        toReadStatus = jsonData["toReadStatus"].intValue
        tokenName = jsonData["tokenName"].stringValue as NSString
        topics = jsonData["topics"].arrayValue as NSArray
        transactionIndex = jsonData["transactionIndex"].intValue
//        value = jsonData["value"].int64Value
        value = jsonData["value"].stringValue as NSString
        v = jsonData["v"].int64Value
    }

    
}

class TokendEtailModel: NSObject {
    var itemArray = [TokendEtailItemModel]()
    
    
    override init() {
        itemArray = NSMutableArray.init() as! [TokendEtailItemModel];
    }
   
    init(jsonData: JSON) {
        let obj =  jsonData["obj"].arrayValue
        for objc in obj as Array<Any> {
            let itemModel = TokendEtailItemModel.init(jsonData: JSON(objc) )
            itemArray.append(itemModel)
        }
    }
    
}


