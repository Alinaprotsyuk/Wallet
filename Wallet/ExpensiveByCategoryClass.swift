//
//  ExpensiveByCategoryClass.swift
//  Wallet
//
//  Created by ITA student on 9/23/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation
import UIKit

class ExpensesByCategory {
    var categoryName: String
    var expenses: Float
    var color: UIColor
    
    init (categoryName : String, expenses: Float, color: UIColor){
        self.categoryName = categoryName
        self.expenses = expenses
        self.color = color
    }

}
