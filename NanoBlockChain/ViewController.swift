//
//  ViewController.swift
//  NanoBlockChain
//
//  Created by Kawabata Kazuki on 2018/03/18.
//  Copyright © 2018年 Kawabata Kazuki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var mineButton: UIButton!
    
    let blockChain = Blockchain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.register(UITableViewCell.self, forCellReuseIdentifier: "blockCell")
        
        mineButton.layer.cornerRadius = 12.0
        mineButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        mineButton.titleLabel?.textColor = UIColor.black
        mineButton.setTitle("採掘", for: .normal)
        mineButton.backgroundColor = UIColor.blue
    }

    // mine
    @IBAction func mine(_ sender: Any) {
        
        self.mineBlock()
        self.tableview.reloadData()
    }
    
    func mineBlock() {
        let lastBlock = blockChain.lastBlock()
        let lastProof = lastBlock.nonce
        let nonce = Blockchain.proofOfWork(lastProof: lastProof)
        blockChain.createTransaction(sender: "0", recipient: "recipient", amount: 1)
        self.blockChain.generateBlock(nonce: nonce)
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blockChain.chain.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "blockCell") {
            
            cell.textLabel?.text = self.blockChain.chain[indexPath.row].description()
            return cell
        }
        
        return UITableViewCell()
    }

}
