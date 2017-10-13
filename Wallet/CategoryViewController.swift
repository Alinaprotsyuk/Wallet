//
//  CategoryViewController.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var newCategoryItem: UITextField!
    @IBOutlet weak var CategoriesTable: UITableView!
    
    let model = DataStore.sharedInstnce

    var enter : Bool = false
    
    private func showMessage(message: String){
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func checkCategoryInList(name: String) -> Bool {
        for item in model.categoriesItems {
            if item.item == name {
                return true
            }
        }
        return false
    }
    
    @IBAction func addCategory(_ sender: UIButton) {
       if newCategoryItem.text != "" {
            if let unwrappedText = newCategoryItem.text {
                let trimmed = unwrappedText.trimmingCharacters(in: .whitespacesAndNewlines)
                if !checkCategoryInList(name: trimmed.capitalized) {
                    let newCategoryListItem = CategoriesItem(item: unwrappedText.capitalized)
                    model.saveCategory(item: newCategoryListItem)
                } else {
                    showMessage(message: "Dublicate category")
                }
            }
            newCategoryItem.text = ""
            view.endEditing(true)
            CategoriesTable.reloadData()
       } else {
            showMessage(message: "You need write some category")
        }
    }
    
    var saveAction : ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "My categories"
        model.categoriesItems.sort(by:{$0.item < $1.item})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.categoriesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = model.categoriesItems[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            model.deleteCategory(indexPath: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if enter {
            let selectedCategory = model.categoriesItems[indexPath.row].item
            self.saveAction!(selectedCategory)
            self.navigationController?.popViewController(animated: true)

        }
    }
}
