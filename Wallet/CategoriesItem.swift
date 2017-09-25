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
            static let description = "description"
            static let type = "type"
        
        }
        
        var item = ""
        var categoryDescription = ""
        var type = ""
        
        override init() {}
        
   
        init(item: String, categoryDescription: String, type: String) {
            self.item = item
            self.categoryDescription = categoryDescription
            self.type = type
        }
        

        required init(coder decoder: NSCoder) {

            if let nameObject = decoder.decodeObject(forKey: Keys.item) as? String {
                item = nameObject
            }
            if let descriptionObject = decoder.decodeObject(forKey: Keys.description) as? String {
                categoryDescription = descriptionObject
            }
            if let typeObject = decoder.decodeObject(forKey: Keys.type) as? String {
                item = typeObject
            }
        }
        
       
        func encode(with coder: NSCoder) {
            
            coder.encode(item, forKey: Keys.item)
        }
        
    }

