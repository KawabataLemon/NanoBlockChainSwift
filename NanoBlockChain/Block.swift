//
//  Block.swift
//  NanoBlockChain
//
//  Created by Kawabata Kazuki on 2018/03/18.
//  Copyright © 2018年 Kawabata Kazuki. All rights reserved.
//

import Foundation

struct Block: Codable {
    let index: Int
    let transactions: [Transaction]
    let nonce: Int
    let previousHash: Data
    
    private let timestamp: Double

    init(index: Int, transactions: [Transaction], nonce: Int, previousHash: Data) {
        
        self.timestamp = Date().timeIntervalSince1970 // 生成時に持たせる。外から渡せると改竄できてしまうため
        
        self.index = index
        self.transactions = transactions
        self.nonce = nonce
        self.previousHash = previousHash
    }
    
    func hash() -> Data {
        return try! JSONEncoder().encode(self).sha256()
    }
    
    func description() -> String {
       return String(data: try! JSONEncoder().encode(self), encoding: .utf8) ?? ""
    }
}

extension Data {
    
    func sha256() -> Data {
        guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else { fatalError() }
        CC_SHA256((self as NSData).bytes, CC_LONG(self.count), res.mutableBytes.assumingMemoryBound(to: UInt8.self))
        return res as Data
    }
    
    func hexDigest() -> String {
        return self.map({ String(format: "%02x", $0) }).joined()
    }
}
