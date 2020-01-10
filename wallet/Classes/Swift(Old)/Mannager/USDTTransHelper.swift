//
//  USDTTransHelper.swift
//  QYWallet
//
//  Created by 崔逢举 on 2019/5/15.
//  Copyright © 2019 崔逢举. All rights reserved.
//

import Foundation
public struct USDTTransHelper {
    
    public static func createUtxo(lockScript: Script,amount: UInt64) -> UnspentTransaction {
        let outputMock = TransactionOutput(value: amount, lockingScript: lockScript.data)
        let outpointMock = TransactionOutPoint(hash: Data(), index: 0)
        return UnspentTransaction(output: outputMock, outpoint: outpointMock)
    }
    public static func createTransaction(utxo: UnspentTransaction) -> Transaction {
        let toAddress: Address = try! AddressFactory.create("1Bp9U1ogV3A14FMvKbRJms7ctyso4Z4Tcx")
        let changeAddress: Address = try! AddressFactory.create("1FQc5LdgGHMHEN9nwkjmz6tWkxhPpxBvBU")
        // 1. inputs
        let unsignedInputs = [TransactionInput(previousOutput: utxo.outpoint,
                                               signatureScript: Data(),
                                               sequence: UInt32.max)]
        
        // 2. outputs
        // 2-1. amount, change, fee
        let amount: UInt64 = 10_000
        let fee: UInt64 = 1000
        let change: UInt64 = utxo.output.value - amount - fee
        
        // 2-2. Script
        let lockingScriptTo = Script(address: toAddress)!
        let lockingScriptChange = Script(address: changeAddress)!
        
        // 2-3. TransactionOutput
        let toOutput = TransactionOutput(value: amount, lockingScript: lockingScriptTo.data)
        let changeOutput = TransactionOutput(value: change, lockingScript: lockingScriptChange.data)
        
        // 3. Tx
        let tx = Transaction(version: 1, inputs: unsignedInputs, outputs: [toOutput, changeOutput], lockTime: 0)
        return tx
    }
    
    
}
