//
//  Transaction.swift
//  Wallet
//
//  Created by ITA student on 9/16/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation

class Transaction: NSObject, NSCoding {
    
    var value : String = ""
    var desc : String = ""
    var categ : String = ""
    var kind : String = ""
    var currentDate = Date()
    
    override init() {}
    
    
    init(value: String, desc: String, categ: String, kind: String, currentDate: Date) {
        self.value = value
        self.desc = desc
        self.categ = categ
        self.kind = kind
        self.currentDate = currentDate
    }
    
    
    required init(coder decoder: NSCoder) {
        
        if let valueObject = decoder.decodeObject(forKey: "value") as? String {
            value = valueObject
        }
        if let descObject = decoder.decodeObject(forKey: "desc") as? String {
            desc = descObject
        }
        if let categObject = decoder.decodeObject(forKey: "categ") as? String {
            categ = categObject
        }
        if let kindObject = decoder.decodeObject(forKey: "kind") as? String {
            kind = kindObject
        }
        if let dateObject = decoder.decodeObject(forKey: "currentDate") as? Date {
            currentDate = dateObject
        }
    }
    
    
    func encode(with coder: NSCoder) {
        
        coder.encode(value, forKey: "value")
        coder.encode(desc, forKey: "desc")
        coder.encode(categ, forKey: "categ")
        coder.encode(kind, forKey: "kind")
        coder.encode(currentDate, forKey: "currentDate")
    }
    
    
}

