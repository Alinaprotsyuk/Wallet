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
    
    var calculateByCategory = [ExpensesByCategory]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My wallet"
        self.model.loadTransactionData()
        self.model.loadCategoriesData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableViewTransactions.reloadData()
        let general = model.calculateGeneral()
        calculateByCategory = model.calculateCategory()
        if general.balance < 0 {
            balance.textColor = UIColor.red
        } else {
            balance.textColor = UIColor.black
        }
        balance.text = "My balance: " + String(format:"%.2f", general.balance) + " ₴"
        calculateProfirs.text = "My profits: " + String(format:"%.2f", general.allProfits) + " ₴"
        calculateSpendings.text = "My spending: " + String(format:"%.2f", general.allSpendings) + " ₴"
    }
    
    @IBAction func showAllReport(_ sender: UIButton) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ChartVC") as! ChartViewController
        myVC.storeForExpensesByCategory = calculateByCategory
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.transactionsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTrans", for: indexPath) as! TableViewCell
        cell.dateOfTransaction.text = ConvertDate.getStringFromDate(date: model.transactionsItems[indexPath.row].currentDate)
        cell.describingOfTransaction.text = model.transactionsItems[indexPath.row].desc
        cell.infoOfTransaction.text = model.transactionsItems[indexPath.row].categ 
        cell.valueOfTransaction.text = String (format: "%.2f", Float(model.transactionsItems[indexPath.row].value)!) + " ₴"
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteTransaction(indexPath: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewDidAppear(true)
        }
    }
}
