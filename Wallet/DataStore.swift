//
//  DataStore.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation
import UIKit

typealias Balance = (balance: Float,allSpendings: Float, allProfits: Float)

class DataStore {
    
    static let sharedInstnce = DataStore()
    private init() {}
    var categoriesItems: [CategoriesItem] = []
    var transactionsItems: [Transaction] = []
    var expensive : [ExpensesByCategory] = []
    
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
        if transactionsItems.count > 0 {
            self.transactionsItems.insert(item, at: 0)
        } else {
            self.transactionsItems.append(item)
        }
        NSKeyedArchiver.archiveRootObject(self.transactionsItems, toFile: filePathTransaction)
    }
    
    func loadTransactionData(){
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePathTransaction) as? [Transaction] {
            self.transactionsItems = ourData
        }
    }
    
    func loadCategoriesData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePathCategory) as? [CategoriesItem] {
            self.categoriesItems = ourData
        }
    }
    
    func deleteCategory(indexPath: Int) {
        self.categoriesItems.remove(at: indexPath)
        NSKeyedArchiver.archiveRootObject(self.categoriesItems, toFile: filePathCategory)
    }
    
    func deleteTransaction(indexPath: Int) {
        transactionsItems.remove(at: indexPath)
        NSKeyedArchiver.archiveRootObject(transactionsItems, toFile: filePathTransaction)
    }
    
    func calculateGeneral() -> (Balance) {
        var balance : Float = 0.0
        let allSpengings = transactionsItems.filter({$0.kind == "Spending"}).map{($0.value as NSString).floatValue}.reduce(0,+)
        let allProfits = transactionsItems.filter({$0.kind == "Profit"}).map{($0.value as NSString).floatValue}.reduce(0,+)
        balance = allProfits - allSpengings
        return (balance, allSpengings, allProfits)
    }
    
    private func randomColor() -> UIColor{
        let red = CGFloat(arc4random_uniform(256))/255.0
        let green = CGFloat(arc4random_uniform(256))/255.0
        let blue = CGFloat(arc4random_uniform(256))/255.0
        return UIColor(red : red, green : green, blue : blue, alpha: 0.5)
    }
    
    func calculateCategory () ->  [ExpensesByCategory] {
        expensive = [ExpensesByCategory]()
        for sortByCategory in categoriesItems {
            var suma: Float = 0.00
            for item in transactionsItems {
                if item.categ == sortByCategory.item {
                    suma += Float(item.value)!
                }
            }
            if suma > 0 {
                expensive.append(ExpensesByCategory(categoryName: sortByCategory.item, expenses: suma, color: randomColor()))
            }
        }
        return expensive
    }
    
    func generateNewReport(beginDate : Date, endDate : Date) -> (Balance) {
        var balance : Float = 0.00
        let allSpengings = transactionsItems.filter({$0.kind == "Spending" && ($0.currentDate > beginDate || $0.currentDate == beginDate) && ($0.currentDate < endDate || $0.currentDate == endDate)}).map{($0.value as NSString).floatValue}.reduce(0,+)
        let allProfits = transactionsItems.filter({$0.kind == "Profit" && ($0.currentDate > beginDate || $0.currentDate == beginDate) && ($0.currentDate < endDate || $0.currentDate == endDate)}).map{($0.value as NSString).floatValue}.reduce(0,+)
        balance = allProfits - allSpengings
        return (balance, allSpengings, allProfits)
    }
    
    func calculateCategory (beginDate : Date, endDate : Date) ->  [ExpensesByCategory] {
        
        expensive = [ExpensesByCategory]()
        
        for sortByCategory in categoriesItems {
            var suma: Float = 0.00
            for item in transactionsItems.filter({($0.currentDate > beginDate || $0.currentDate == beginDate) && ($0.currentDate < endDate || $0.currentDate == endDate)}) {
                    if item.categ == sortByCategory.item {
                        suma += Float(item.value)!
                    }
                }
            if suma > 0 {
                expensive.append(ExpensesByCategory(categoryName: sortByCategory.item, expenses: suma, color: randomColor()))
            }
        }
        return expensive
    }
    
}


