//
//  NewReportViewController.swift
//  Wallet
//
//  Created by ITA student on 9/27/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class NewReportViewController: UIViewController, UITextFieldDelegate {
    
    let model = DataStore.sharedInstnce
    var allTransactions = [Transaction]()
    var allCategories = [CategoriesItem]()
    var calculate = [Float]()
    var calculateByCategory = [ExpensesByCategory]()
    
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var from: UILabel!
    
    @IBOutlet weak var startDate: UIDatePicker!
   
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var newBalance: UILabel!
    
    @IBOutlet weak var newSpending: UILabel!
    
    @IBOutlet weak var newProfits: UILabel!
    
    func showMessage(message: String){
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func generateReport(_ sender: UIButton) {
        let start = startDate.date
        let end = endDate.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .none
        
            from.text = dateFormatter.string(from: start)
            to.text = dateFormatter.string(from: end)
            calculate = generateNewReport(beginDate : dateFormatter.date(from: from.text!)!, endDate : dateFormatter.date(from: to.text!)!, transaction : allTransactions)
            calculateByCategory = calculateCategoryByDay(beginDate: dateFormatter.date(from: from.text!)!, endDate: dateFormatter.date(from: to.text!)!, transaction: allTransactions, category: allCategories)
            print(calculate[0], calculate[1], calculate[2])
        for index in calculateByCategory{
            print(index.categoryName,index.expenses)
        }
        
            newProfits.isHidden = false
            newSpending.isHidden = false
            newBalance.isHidden = false
            detailButton.isHidden = false
            if calculate[0] < 0 {
                newBalance.textColor = UIColor.red
            } else {
                newBalance.textColor = UIColor.black
            }
            newBalance.text = "Balance: " + String(format: "%.2f", calculate[0])
            newSpending.text = "Spendding: " + String(format: "%.2f", calculate[1])
            newProfits.text = "Profits: " + String(format: "%.2f", calculate[2])
    }
    
    @IBOutlet weak var detailButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New report"
        self.allTransactions = self.model.loadData()
        self.allCategories = self.model.loadCategoriesData()
        newProfits.isHidden = true
        newSpending.isHidden = true
        newBalance.isHidden = true
        detailButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

