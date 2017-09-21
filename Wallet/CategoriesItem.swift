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
        
        private var _item = ""
        
        override init() {}
        
   
        init(item: String) {
            self._item = item
        }
        

        required init(coder decoder: NSCoder) {

            if let nameObject = decoder.decodeObject(forKey: Keys.item) as? String {
                _item = nameObject
            }
        }
        
       
        func encode(with coder: NSCoder) {
            
            coder.encode(_item, forKey: Keys.item)
        }
        
        var name: String {
            get {
                return _item
            }
            set {
                _item = newValue
            }
        }
    }

