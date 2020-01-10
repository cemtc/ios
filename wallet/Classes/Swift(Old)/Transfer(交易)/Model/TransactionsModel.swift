//
//  TransactionsModel.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/11.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import UIKit
import SwiftyJSON
class TransactionsModel: NSObject {
    var blockNumber: String!
    var timeStamp: String!
    var transacthash: String!
    var nonce: String!
    var blockHash: String!
    var transactionIndex: String!
    var from: String!
    var to: String!
    var value: String!
    var gas: String!
    var gasPrice: String!
    var isError: String!
    var txreceipt_status: String!
    var input: String!
    var contractAddress: String!
    var cumulativeGasUsed: String!
    var gasUsed: String!
    var confirmations: String!
    
    override init() {
        
    }
    init(jsonData: JSON) {
        transacthash = jsonData["hash"].stringValue
         blockNumber = jsonData["blockNumber"].stringValue
        timeStamp = jsonData["timeStamp"].stringValue
        nonce = jsonData["nonce"].stringValue
        blockHash = jsonData["blockHash"].stringValue
        transactionIndex = jsonData["transactionIndex"].stringValue
        from = jsonData["from"].stringValue
        to = jsonData["to"].stringValue
        value = jsonData["value"].stringValue
        gas = jsonData["gas"].stringValue
        gasPrice = jsonData["gasPrice"].stringValue
        isError = jsonData["isError"].stringValue
        txreceipt_status = jsonData["txreceipt_status"].stringValue
        input = jsonData["input"].stringValue
        contractAddress = jsonData["contractAddress"].stringValue
        gasUsed = jsonData["gasUsed"].stringValue
        confirmations = jsonData["confirmations"].stringValue
    }
}
