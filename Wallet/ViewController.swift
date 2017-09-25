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
    
    @IBOutlet weak var calculateProfirs: UILabel!
    
    @IBOutlet weak var calculateSpendings: UILabel!
    
    let model = DataStore.sharedInstnce
    
    var allTransactions = [Transaction]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My wallet"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.allTransactions = self.model.loadData()
        self.tableViewTransactions.reloadData()
        balance.text = "My balance: " + String(format:"%.2f", model.calculateBalance(item: allTransactions).balance)
        calculateProfirs.text = "My profits: " + String(format:"%.2f", model.calculateBalance(item: allTransactions).allProfits)
        calculateSpendings.text = "My spending: " + String(format:"%.2f", model.calculateBalance(item: allTransactions).allSpendings)
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
        cell.describingOfTransaction.text = allTransactions[indexPath.row].desc
        cell.infoOfTransaction.text = allTransactions[indexPath.row].categ + " ☞ " + model.getTime(date: allTransactions[indexPath.row].currentDate)
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
