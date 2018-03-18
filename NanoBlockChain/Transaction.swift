 //
//  Transaction.swift
//  NanoBlockChain
//
//  Created by Kawabata Kazuki on 2018/03/18.
//  Copyright © 2018年 Kawabata Kazuki. All rights reserved.
//

import Foundation

//
// Transaction
//
// とりひき情報
// Irohaの定義
// message Transaction {
//    Payload payload = 1;
//    repeated Signature signature = 2;
// }
// message Payload {
//    repeated Command commands = 1;
//    string creator_account_id = 2;
//    uint64 tx_counter  = 3;
//    uint64 created_time = 4;
// }
// message Signature {
//     bytes pubkey    = 1;
//     bytes signature = 2;
// }
typealias Address = String

 struct Transaction: Codable {
    let sender: Address
    let reciever: Address
    let amount: Int
}

