//
//  CalculateDataStore.swift
//  Wallet
//
//  Created by ITA student on 9/26/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation
import UIKit

/*typealias Balance = (balance: Float,allSpendings: Float, allProfits: Float)

class CalculateDataStore{
    
    
    
    func calculateGeneral() -> (Balance) {
        var sumaSpending : Float = 0.00
        var sumaProfit : Float = 0.00
        var balance : Float = 0.00
        for object in transactionsItems{
            if object.kind == "Spending" {
                sumaSpending += Float(object.value)! * 100
            } else {
                sumaProfit += Float(object.value)! * 100
            }
        }
        balance = (sumaProfit - sumaSpending) / 100
        return (balance, sumaSpending / 100, sumaProfit / 100)
    }

}*/





   /* func randomColor() -> UIColor{
        let red = CGFloat(arc4random_uniform(256))/255.0
        let green = CGFloat(arc4random_uniform(256))/255.0
        let blue = CGFloat(arc4random_uniform(256))/255.0
        return UIColor(red : red, green : green, blue : blue, alpha: 0.5)
    }
    
     func calculateCategory (transaction: [Transaction], category: [CategoriesItem]) ->  [ExpensesByCategory] {
        expenses = [ExpensesByCategory]()
        for sortByCategory in model.categoriesItems {
            var suma: Float = 0.00
            for item in model.transactionsItems {
                if item.categ == sortByCategory.item {
                    suma += Float(item.value)!
                }
            }
            
            expenses.append(ExpensesByCategory(categoryName: sortByCategory.item, expenses: suma, color: randomColor()))
        }
        return expenses
    }

    func generateNewReport(beginDate : Date, endDate : Date, transaction : [Transaction]) -> [Float]{
        var sumaSpending : Float = 0.00
        var sumaProfit : Float = 0.00
        var balance : Float = 0.00
    
        for object in model.transactionsItems {
        
            if (object.currentDate > beginDate || object.currentDate == beginDate) && (object.currentDate < endDate || object.currentDate == endDate) {
                if object.kind == "Spending" {
                    sumaSpending += Float(object.value)!
                } else {
                sumaProfit += Float(object.value)!
                }
            }
        
        }
        balance = sumaProfit - sumaSpending
        return [balance, sumaSpending, sumaProfit]
    }

    func calculateCategoryByDay (beginDate : Date, endDate : Date, transaction: [Transaction], category: [CategoriesItem]) ->  [ExpensesByCategory] {
        
        expenses = [ExpensesByCategory]()
        
        for sortByCategory in model.categoriesItems {
        var suma: Float = 0.00
            for item in model.transactionsItems {
                if (item.currentDate > beginDate || item.currentDate == beginDate) && (item.currentDate < endDate || item.currentDate == endDate) {
                    if item.categ == sortByCategory.item {
                    suma += Float(item.value)!
                    }
                }
            }
            expenses.append(ExpensesByCategory(categoryName: sortByCategory.item, expenses: suma, color: randomColor()))
            }
    
        return expenses
    }*/
