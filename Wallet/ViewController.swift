//
//  ViewController.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   /* @IBOutlet weak var tableResault: UITableView!
    
    let model = DataStore.sharedInstnce
    
    var allTransactions = [Transaction]()
    var calculation = [Float]()
    let titles = ["Balance:", "All spendings:", "All profits:"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My wallet"
        self.tableResault.delegate = self
        self.tableResault.dataSource = self
        self.allTransactions = self.model.loadData()
        calculation = calculateBalance(item: allTransactions)
    }
    
    override func viewDidAppear(_ animated: Bool) {
      self.tableResault.reloadData()
        calculation = calculateBalance(item: allTransactions)
    }
    
   func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return calculation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTrans", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = String(format:"%.2f", calculation[indexPath.row])
        return cell
        
    }
    
}*/
    @IBOutlet weak var balance: UILabel!
    
    @IBOutlet weak var tableViewTransactions: UITableView!
    
    @IBOutlet weak var calculateProfirs: UILabel!
    
    @IBOutlet weak var calculateSpendings: UILabel!
    
    let model = DataStore.sharedInstnce
    
    var allTransactions = [Transaction]()
    var allCategories = [CategoriesItem]()
    var calculateByCategory = [ExpensesByCategory]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My wallet"
        calculateByCategory = calculateCategory(transaction: allTransactions, category: allCategories)
        for index in calculateByCategory{
            print(index.categoryName,index.expenses,index.color)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.allTransactions = self.model.loadData()
        self.allCategories = self.model.loadCategoriesData()
        //allTransactions.sort (by:{$0.currentDate > $1.currentDate})
        self.tableViewTransactions.reloadData()
        let balanceItem = calculateBalance(item: allTransactions).balance
        if balanceItem < 0 {
            balance.textColor = UIColor.red
        } else {
            balance.textColor = UIColor.black
        }
        balance.text = "My balance: " + String(format:"%.2f", balanceItem) //calculateBalance(item: allTransactions).balance
        calculateProfirs.text = "My profits: " + String(format:"%.2f", calculateBalance(item: allTransactions).allProfits)
        calculateSpendings.text = "My spending: " + String(format:"%.2f", calculateBalance(item: allTransactions).allSpendings)
        calculateByCategory = calculateCategory(transaction: allTransactions, category: allCategories)
        for index in calculateByCategory{
            print(index.categoryName,index.expenses,index.color)
        }
    }
    
    @IBAction func showAllReport(_ sender: UIButton) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ChartVC") as! ChartViewController
        myVC.storeForExpensesByCategory = calculateByCategory
        navigationController?.pushViewController(myVC, animated: true)
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
        cell.infoOfTransaction.text = allTransactions[indexPath.row].categ + " ☞ " + getStringFromDAte(date: allTransactions[indexPath.row].currentDate)
        cell.valueOfTransaction.text = String (format: "%.2f", Float(allTransactions[indexPath.row].value)!)
        return cell
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = .detailButton
        
        cell.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
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
