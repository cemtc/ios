//
//  StandardTransactionBuilder.swift
//
//  Copyright © 2018 BitcoinKit developers
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//USDTTransactionBuilder 和 StandardTransactionBuilder 一样

import Foundation

public struct StandardTransactionBuilder: TransactionBuilder {
    public init() {}
    public func build(destinations: [(address: Address, amount: UInt64)], utxos: [UnspentTransaction],intNum: Int) throws -> UnsignedTransaction {
        
        /*
        let outputs = try destinations.map { (address: Address, amount: UInt64) -> TransactionOutput in
            guard let lockingScript = Script(address: address)?.data else {
                throw TransactionBuildError.error("Invalid address type")
            }
            return TransactionOutput(value: amount, lockingScript: lockingScript)
        }
        */
        //USDT打开
        //重写代码就是下面这句话!!!!!!!!!
        var outputs = try destinations.map { (address: Address, amount: UInt64) -> TransactionOutput in
            guard let lockingScript = Script(address: address)?.data else {
                throw TransactionBuildError.error("Invalid address type")
            }
            return TransactionOutput(value: amount, lockingScript: lockingScript)
        }
        
        if intNum == 0 {
            print("btc")
        }else{
            print("usdt")
            
            let usdtHex = "6a146f6d6e69000000000000001f\(String(format: "%016x", intNum))"
            let usdtTxOutput = TransactionOutput(value: 0, lockingScript: Script(hex: usdtHex)!.data)
            outputs.append(usdtTxOutput) //add a new script output
        }

        let unsignedInputs = utxos.map { TransactionInput(previousOutput: $0.outpoint, signatureScript: Data(), sequence: UInt32.max) }
        let tx = Transaction(version: 1, inputs: unsignedInputs, outputs: outputs, lockTime: 0)
        return UnsignedTransaction(tx: tx, utxos: utxos)
    }
}

enum TransactionBuildError: Error {
    case error(String)
}
