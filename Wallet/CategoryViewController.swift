//
//  CategoryViewController.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var category = DataStore.sharedInstnce
    
    @IBOutlet weak var newCategoryItem: UITextField!
    @IBOutlet weak var CategoriesTable: UITableView!
    
    
    @IBAction func addCategory(_ sender: UIButton) {
        
        if newCategoryItem.text != "" {
            if let unwrappedText = newCategoryItem.text {
                let newCategoryListItem = CategoriesItem(item: unwrappedText.capitalized)
                self.saveData(item: newCategoryListItem)
            }
            newCategoryItem.text = ""
            view.endEditing(true)
            CategoriesTable.reloadData()
        }
        
    }
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Data").path)
    }
    
    private func saveData(item: CategoriesItem) {
        self.category.categoriesItems.append(item)
        NSKeyedArchiver.archiveRootObject(self.category.categoriesItems, toFile: filePath)
    }
    
    private func loadData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [CategoriesItem] {
            self.category.categoriesItems = ourData
        }
    }
    
    private func deleteData(indexPath: IndexPath) {
        self.category.categoriesItems.remove(at: indexPath.row)
        NSKeyedArchiver.archiveRootObject(self.category.categoriesItems, toFile: filePath)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.categoriesItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = category.categoriesItems[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteData(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        }*/
        self.performSegue(withIdentifier: "chooseCategoryItem", sender: category.categoriesItems[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "chooseCategoryItem" {
            /*let upcoming : TransViewController = (segue.destination as? TransViewController)!
            let indexPath = self.CategoriesTable.indexPathForSelectedRow
            let categorySelected = self.category.categoriesItems[(indexPath?.row)!] as? String
            upcoming.itemCategoryName = categorySelected*/
            
            let upcoming = segue.destination as? TransViewController
            upcoming!.itemCategoryName = sender as? String
            /*let indexPath = self.CategoriesTable.indexPathForSelectedRow
            self.CategoriesTable.deselectRow(at: indexPath!, animated: true)*/
            
            
   // }
    }
}
