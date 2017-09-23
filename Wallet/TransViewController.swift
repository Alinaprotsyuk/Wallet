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
    
    let model = DataStore.sharedInstnce
    
    var myTransaction = [Transaction]()
    
    /*func getTime() -> String {
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentDate.text = model.getTime(date: Date())
        
        listOfTransactions.isHidden = true
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showMessage(message: String){
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        if (value.text?.isEmpty)! || (desc.text?.isEmpty)! || (categotyName.text?.isEmpty)! || (kindOfTransaction.text?.isEmpty)! {
            showMessage(message: "You should put all information")
        } else {
            let newTransaction = Transaction(value: value.text!, desc: desc.text!, categ: categotyName.text!, kind: kindOfTransaction.text!, currentDate: Date())
               
            model.saveTransaction(item: newTransaction)
            _ = navigationController?.popViewController(animated: true)
        }
    
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var result = true
        
            let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789.-")
            let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet as CharacterSet)
            result = (replacementStringIsLegal != nil)
        
    return result
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseCategoryItem" {
            
            if let vc = segue.destination as? CategoryViewController {
                vc.enter = true
                vc.saveAction = {selectedCategory in
                    self.categotyName.text = selectedCategory
                }
            }
        }
    }
    

    
}



