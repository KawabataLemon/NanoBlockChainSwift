//
//  BlockChain.swift
//  NanoBlockChain
//
//  Created by Kawabata Kazuki on 2018/03/18.
//  Copyright © 2018年 Kawabata Kazuki. All rights reserved.
//

import Foundation

// BlockChain
class Blockchain {
    
    private var currentTransactions: [Transaction] = []
    var chain: [Block] = []
    
    init() {
        //
        // Irohaでは、インスタンス生成時にgenesis.blockを使う
        // Etheriumとかも基本的に同じ
        //
        generateBlock(nonce: 100, previousHash: "1".data(using: .utf8))
    }
    
    @discardableResult
    func generateBlock(nonce: Int, previousHash: Data? = nil) -> Block {

        let block = Block(index: chain.count+1,
                          transactions: currentTransactions,
                          nonce: nonce,
                          previousHash: previousHash ?? lastBlock().hash())

        // トランザクションがなかったら不用意にblock生成する必要がない
        currentTransactions = []
        chain.append(block)
        
        return block
    }
    
    @discardableResult
    func createTransaction(sender: Address, recipient: Address, amount: Int) -> Int {
        let transaction = Transaction(sender: sender, reciever: recipient, amount: amount)
        currentTransactions.append(transaction)
        return lastBlock().index + 1
    }
    
    func lastBlock() -> Block {

        if self.chain.isEmpty || self.chain.last == nil {
            fatalError("ブロックが存在しません。")
        }
        
        return self.chain.last!
    }
    
    class func proofOfWork(lastProof: Int) -> Int {
        var proof: Int = 0
        while !validProof(lastProof: lastProof, proof: proof) {
            proof += 1
        }
        return proof
    }
    
    class func validProof(lastProof: Int, proof: Int) -> Bool {
        guard let guess = String("\(lastProof)\(proof)").data(using: .utf8) else {
            fatalError()
        }
        let guess_hash = guess.sha256().hexDigest()
        return guess_hash.prefix(4) == "0000"
    }
}

