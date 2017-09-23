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
    
    var myCategory = [CategoriesItem]()

    var enter : Bool = false
    
    @IBAction func addCategory(_ sender: UIButton) {
        
        if newCategoryItem.text != "" {
            if let unwrappedText = newCategoryItem.text {
                let newCategoryListItem = CategoriesItem(item: unwrappedText.capitalized)
                model.saveCategory(item: newCategoryListItem)
                myCategory.append(newCategoryListItem)
            }
            newCategoryItem.text = ""
            view.endEditing(true)
            CategoriesTable.reloadData()
        }
        
    }
    
    var saveAction : ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.myCategory = self.model.loadCategoriesData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = myCategory[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myCategory.remove(at: indexPath.row)
            model.deleteCategory(indexPath: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if enter {
            let selectedCategory = myCategory[indexPath.row].name
            self.saveAction!(selectedCategory)
            self.navigationController?.popViewController(animated: true)

        }
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chooseCategoryItem" {
            /*let upcoming : TransViewController = (segue.destination as? TransViewController)!
            let indexPath = self.CategoriesTable.indexPathForSelectedRow
            let categorySelected = self.category.categoriesItems[(indexPath?.row)!] as? String
            upcoming.itemCategoryName = categorySelected*/
            
            let upcoming = segue.destination as? TransViewController
            upcoming!.itemCategoryName = sender as? String
            /*let indexPath = self.CategoriesTable.indexPathForSelectedRow
            self.CategoriesTable.deselectRow(at: indexPath!, animated: true)*/
            
            
        }
    }*/
}
