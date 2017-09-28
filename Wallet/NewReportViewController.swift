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
    var calculate = [Float]()
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var from: UILabel!
    
    @IBOutlet weak var startDate: UIDatePicker!
   
    @IBOutlet weak var endDate: UIDatePicker!
    
    @IBOutlet weak var newBalance: UILabel!
    
    @IBOutlet weak var newSpending: UILabel!
    
    @IBOutlet weak var newProfits: UILabel!
    
    @IBAction func generateReport(_ sender: UIButton) {
        let start = startDate.date
        let end = endDate.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        from.text = dateFormatter.string(from: start)
        to.text = dateFormatter.string(from: end)
        calculate = generateNewReport(beginDate : dateFormatter.date(from: from.text!)!, endDate : dateFormatter.date(from: to.text!)!, transaction : allTransactions)
        print(calculate[0], calculate[1], calculate[2])
        newProfits.isHidden = false
        newSpending.isHidden = false
        newBalance.isHidden = false
        newBalance.text = "Balance: " + String(format: "%.2f", calculate[0])
        newSpending.text = "Spendding: " + String(format: "%.2f", calculate[1])
        newProfits.text = "Profits: " + String(format: "%.2f", calculate[2])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New report"
        self.allTransactions = self.model.loadData()
        newProfits.isHidden = true
        newSpending.isHidden = true
        newBalance.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }

