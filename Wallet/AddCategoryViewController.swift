//
//  AddCategoryViewController.swift
//  Wallet
//
//  Created by ITA student on 9/24/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

/*import UIKit

class AddCategoryViewController: UIViewController, UIPickerViewDelegate {
    
    @IBOutlet weak var categoryTitle: UITextField!

    @IBOutlet weak var describtionCategory: UITextView!
    
    @IBOutlet weak var typeOfCategory: UITextField!
    
    let model = DataStore.sharedInstnce
    
    var myCategory = [CategoriesItem]()
    
    let kindTransaction = ["Spending", "Profit"]
    
    @IBOutlet weak var listOfTransaction: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Add new category title"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCategoryItem))
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func addCategoryItem() {
        if !(categoryTitle.text?.isEmpty)! && !(typeOfCategory.text?.isEmpty)! {
            let newCategoryListItem = CategoriesItem(item: categoryTitle.text!.capitalized)
                model.saveCategory(item: newCategoryListItem)
                myCategory.append(newCategoryListItem)
            
            /*newCategoryItem.text = ""
            view.endEditing(true)
            CategoriesTable.reloadData()*/
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        self.typeOfCategory.text = self.kindTransaction[row]
        listOfTransaction.isHidden = true
        
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
