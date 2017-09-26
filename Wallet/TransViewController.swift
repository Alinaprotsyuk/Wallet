//
//  TransViewController.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class TransViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentDate: UILabel!
    
    var itemCategoryName : String?
    
    @IBOutlet weak var value: UITextField!
    
    //@IBOutlet weak var desc: UITextField!
    
    var typeOfTransaction : String?
    
    @IBOutlet weak var categotyName: UITextField!
    
    @IBOutlet weak var desc: UITextView!
    
    @IBOutlet weak var button: UIButton!
    
    let model = DataStore.sharedInstnce
    
    var myTransaction = [Transaction]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My transaction"
        currentDate.text = getTime(date: Date())
        //listOfTransactions.isHidden = true
    }
    
    @IBAction func kindOfTransaction(_ sender: UISwitch) {
        if sender.isOn {
            button.isEnabled = true
            categotyName.text = ""
        }
        else {
            button.isEnabled = false
            typeOfTransaction = "Profit"
            categotyName.text = "Profit"
        }
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
            if button.isEnabled{
                newTransaction = Transaction(value: value.text!, desc: desc.text!, categ: categotyName.text!, kind: "Spending", currentDate: Date())
            } else{
                newTransaction = Transaction(value: value.text!, desc: desc.text!, categ: typeOfTransaction!, kind: "Profit" , currentDate: Date())
            }
            model.saveTransaction(item: newTransaction)
            _ = navigationController?.popViewController(animated: true)
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



