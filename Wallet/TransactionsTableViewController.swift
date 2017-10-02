//
//  TransactionsTableViewController.swift
//  Wallet
//
//  Created by ITA student on 9/28/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

/*import UIKit

class TransactionsTableViewController: UITableViewController {
    
    let model = DataStore.sharedInstnce
    
    var allTransactions = [Transaction]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My transactions"
        self.allTransactions = self.model.loadData()
        allTransactions.sort (by:{$0.currentDate > $1.currentDate})
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.allTransactions = self.model.loadData()
        allTransactions.sort (by:{$0.currentDate > $1.currentDate})
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return allTransactions.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTransaction", for: indexPath) as! TableViewCell
        cell.describingOfTransaction.text = allTransactions[indexPath.row].desc
        cell.infoOfTransaction.text = allTransactions[indexPath.row].categ + " ☞ " + getTime(date: allTransactions[indexPath.row].currentDate)
        cell.valueOfTransaction.text = String (format: "%.2f", Float(allTransactions[indexPath.row].value)!)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            allTransactions.remove(at: indexPath.row)
            model.deleteTransaction(indexPath: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            viewDidAppear(true)
        }
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}*/
