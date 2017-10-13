//
//  TransViewController.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class TransViewController: UIViewController, UITextFieldDelegate {
    
    var itemCategoryName : String?
    
    @IBOutlet weak var value: UITextField!
    
    var typeOfTransaction : String?
    
    @IBOutlet weak var categotyName: UITextField!
    
    @IBOutlet weak var desc: UITextView!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet var datePickerTF: UITextField!
    
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var type: UISegmentedControl!
    
    @IBOutlet weak var toSeeChooseOfTransaction: UILabel!
    
    @IBAction func chooseTypeOfTransaction(_ sender: UISegmentedControl) {
        if type.selectedSegmentIndex == 0 {
            button.isEnabled = false
            typeOfTransaction = "Profit"
            categotyName.text = "Profit"
            toSeeChooseOfTransaction.text = "Profit"
        } else {
            button.isEnabled = true
            categotyName.text = ""
            toSeeChooseOfTransaction.text = "Spending"
        }
    }
    let model = DataStore.sharedInstnce
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My transaction"
        createDatePicker()
        type.selectedSegmentIndex = 1
        toSeeChooseOfTransaction.text = "Spending"
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
        if (value.text?.isEmpty)! || (desc.text?.isEmpty)! || (categotyName.text?.isEmpty)! {
            showMessage(message: "You should put all information")
        } else {
            var newTransaction = Transaction()
            let dateObj = ConvertDate.getDateFromString(string: datePickerTF.text!)
            if button.isEnabled{
                newTransaction = Transaction(value: value.text!, desc: desc.text!.capitalized, categ: categotyName.text!, kind: "Spending", currentDate: dateObj)
            } else{
                newTransaction = Transaction(value: value.text!, desc: desc.text!.capitalized, categ: typeOfTransaction!, kind: "Profit" , currentDate: dateObj)
            }
            model.saveTransaction(item: newTransaction)
            _ = navigationController?.popViewController(animated: true)
        }
    
    }
    
    func createDatePicker(){
        
        //format for datepicker display
        datePicker.datePickerMode = .date
        
        //assign datepicker to our textfield
        datePickerTF.inputView = datePicker
        
        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneClicked))
        
        toolbar.setItems([doneButton], animated: true)
        
        datePickerTF.inputAccessoryView = toolbar
    }
    
    func doneClicked(){
        datePickerTF.text = ConvertDate.getStringFromDate(date: datePicker.date)
        self.view.endEditing(true)
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



