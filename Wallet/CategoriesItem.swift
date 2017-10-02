//
//  CategoriesArray.swift
//  Wallet
//
//  Created by ITA student on 9/15/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation

    class CategoriesItem: NSObject, NSCoding {
        
        struct Keys {
            static let item = "item"
        }
        
        var item = ""
        
        override init() {}
        
   
        init(item: String) {
            self.item = item
        }
        

        required init(coder decoder: NSCoder) {

            if let nameObject = decoder.decodeObject(forKey: Keys.item) as? String {
                item = nameObject
            }
        }
       
        func encode(with coder: NSCoder) {
            
            coder.encode(item, forKey: Keys.item)
        }
        
    }

