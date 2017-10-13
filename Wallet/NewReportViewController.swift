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

    var calculateByCategory = [ExpensesByCategory]()
    
    @IBOutlet weak var to: UILabel!
    
    @IBOutlet weak var from: UILabel!
    
    @IBOutlet weak var startDate: UIDatePicker!
   
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var newBalance: UILabel!
    
    @IBOutlet weak var newSpending: UILabel!
    
    @IBOutlet weak var newProfits: UILabel!
    
    private func showMessage(message: String){
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func generateReport(_ sender: UIButton) {
        let start = startDate.date
        let end = endDate.date
        from.text = ConvertDate.getStringFromDate(date: start)
        to.text = ConvertDate.getStringFromDate(date: end)
        newProfits.isHidden = false
        newSpending.isHidden = false
        newBalance.isHidden = false
        detailButton.isHidden = false
        let calculate = model.generateNewReport(beginDate : ConvertDate.getDateFromString(string: from.text!), endDate : ConvertDate.getDateFromString(string: to.text!))
        calculateByCategory = model.calculateCategory(beginDate: ConvertDate.getDateFromString(string: from.text!), endDate: ConvertDate.getDateFromString(string: to.text!))
        
        if calculate.balance < 0 {
            newBalance.textColor = UIColor.red
        } else {
            newBalance.textColor = UIColor.black
        }
        newBalance.text = "Balance: " + String(format: "%.2f", calculate.balance) + " ₴"
        newSpending.text = "Spendding: " + String(format: "%.2f", calculate.allSpendings) + " ₴"
        newProfits.text = "Profits: " + String(format: "%.2f", calculate.allProfits) + " ₴"
    }
    
    @IBOutlet weak var detailButton: UIButton!
    
    @IBAction func showNewReport(_ sender: UIButton) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "ChartVC") as! ChartViewController
        myVC.storeForExpensesByCategory = calculateByCategory
        navigationController?.pushViewController(myVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New report"

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

