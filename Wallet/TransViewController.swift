//
//  TransViewController.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class TransViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate {

    @IBOutlet weak var currentDate: UILabel!
    
    @IBOutlet weak var kindOfTransaction: UITextField!
    
    @IBOutlet weak var listOfTransactions: UIPickerView!
    
    let kindTransaction = ["Spending", "Profit"]
    
    var itemCategoryName : String?
    
    @IBOutlet weak var value: UITextField!
    
    @IBOutlet weak var desc: UITextField!
    
    @IBOutlet weak var categotyName: UITextField!
    
    @IBOutlet weak var currentCategory: UILabel!
    
    var myTransactions = Transaction()
    
   /* @IBAction func chooseCategory(_ sender: UIButton) {
        if let item = itemCategoryName {
            currentCategory.text = item
        }
    }*/
    
    @IBAction func saveTransaction(_ sender: UIBarButtonItem) {
        if !value.text!.isEmpty {
            myTransactions.value.append(Double(value.text!)!)
        }
        if !desc.text!.isEmpty {
            myTransactions.desc.append(desc.text!)
        }
        if !categotyName.text!.isEmpty {
            myTransactions.categ.append(categotyName.text!)
        }
        if !kindOfTransaction.text!.isEmpty {
            myTransactions.kind.append(kindOfTransaction.text!)
        }
        
       /* myTransactions(value: Double(value.text!), desc: desc.text!, categ: categotyName.text!, kind: kindOfTransaction.text!)*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        currentDate.text = "\(formatter.string(from: date))"
        listOfTransactions.isHidden = true
        
        if let item = itemCategoryName {
            currentCategory.text = item
            categotyName.text = item
        }
        print(itemCategoryName)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kindTransaction.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return kindTransaction[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.kindOfTransaction.text = self.kindTransaction[row]
        listOfTransactions.isHidden = true
    
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.kindOfTransaction {
            listOfTransactions.isHidden = false
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

}
