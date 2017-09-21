//
//  ViewController.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var tableViewTransactions: UITableView!
    
    let model = DataStore.sharedInstnce
    
    var allTransactions = [Transaction]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.allTransactions = self.model.loadData()
        self.tableViewTransactions.reloadData()
        balance.text = String(format:"%.2f", model.calculateBalance(item: allTransactions))
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(transaction.transactions.count)
        return allTransactions.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTrans", for: indexPath) as! TableViewCell
        cell.textLabel?.text = allTransactions[indexPath.row].desc
        cell.detailTextLabel?.text = allTransactions[indexPath.row].categ + " ☞ " + allTransactions[indexPath.row].currentDate
        cell.valueOfTransaction.text = allTransactions[indexPath.row].value //String (format: "%.2f", allTransactions[indexPath.row].value)
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            allTransactions.remove(at: indexPath.row)
            model.deleteTransaction(indexPath: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewDidAppear(true)
        }
    }
}
