//
//  ExpensiveByCategoryClass.swift
//  Wallet
//
//  Created by ITA student on 9/23/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation
import UIKit

class expensesByCategory {
    var categoryName: String
    var expenses: Double
    var color: UIColor
    
    init (categoryName : String, expenses: Double, color: UIColor){
        self.categoryName = categoryName
        self.expenses = expenses
        self.color = color
    }
    
    
}
