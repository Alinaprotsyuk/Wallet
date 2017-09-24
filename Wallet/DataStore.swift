//
//  DataStore.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation
import UIKit

class DataStore {
    
    static let sharedInstnce = DataStore()
    private init() {}
    var categoriesItems: [CategoriesItem] = []
    var transactionsItems: [Transaction] = []
    var expenses : [expensesByCategory] = []    
    
    var filePathCategory: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Data").path)
    }
    
    var filePathTransaction: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        return (url!.appendingPathComponent("Transaction").path)
    }
    
  
    func saveCategory(item: CategoriesItem) {
        self.categoriesItems.append(item)
        NSKeyedArchiver.archiveRootObject(self.categoriesItems, toFile: filePathCategory)
    }
    
    func saveTransaction(item: Transaction) {
        self.transactionsItems.append(item)
        NSKeyedArchiver.archiveRootObject(self.transactionsItems, toFile: filePathTransaction)
    }
    

    func loadData() -> [Transaction] {
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePathTransaction) as? [Transaction] {
            self.transactionsItems = ourData
        }
        return self.transactionsItems
    }
    
    func loadCategoriesData() -> [CategoriesItem] {
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePathCategory) as? [CategoriesItem] {
            self.categoriesItems = ourData
        }
        return self.categoriesItems
    }
    
    func deleteCategory(indexPath: Int) {
        self.categoriesItems.remove(at: indexPath)
        NSKeyedArchiver.archiveRootObject(self.categoriesItems, toFile: filePathCategory)
    }
    
    func deleteTransaction(indexPath: Int) {
        transactionsItems.remove(at: indexPath)
        NSKeyedArchiver.archiveRootObject(transactionsItems, toFile: filePathTransaction)
    }
    
    func calculateBalance(item: [Transaction]) -> (balance: Double,allSpendings: Double, allProfits: Double) {
        var sumaSpending = 0.00
        var sumaProfit = 0.00
        var balance = 0.00
            for object in transactionsItems {
                if object.kind == "Spending" {
                    sumaSpending += Double(object.value)! * 100
                } else {
                    sumaProfit += Double(object.value)! * 100
                }
            }
        balance = (sumaProfit - sumaSpending) / 100
        return (balance, sumaSpending / 100, sumaProfit / 100)
    }
    
    func getTime(date: Date) -> String {
        //let date = Date()
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(arc4random_uniform(256))/255.0
        let green = CGFloat(arc4random_uniform(256))/255.0
        let blue = CGFloat(arc4random_uniform(256))/255.0
        return UIColor(red : red, green : green, blue : blue, alpha: 0.5)
    }
    
    func calculateCategory (transaction: [Transaction], category: [CategoriesItem]) ->  [expensesByCategory] {
        expenses = [expensesByCategory]()
        for sortByCategory in category {
            var suma = 0.00
        
            for item in transaction {
                if item.categ == sortByCategory.name {
                    suma += Double(item.value)!
                }
            }
            
            expenses.append(expensesByCategory(categoryName: sortByCategory.name, expenses: suma, color: randomColor()))
        }
        
        return expenses
    }
    
}
