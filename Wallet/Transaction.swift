//
//  Transaction.swift
//  Wallet
//
//  Created by ITA student on 9/16/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation

class Transaction: NSObject, NSCoding {
    
    private var _value : String = ""
    private var _desc : String = ""
    private var _categ : String = ""
    private var _kind : String = ""
    private var _currentDate : String = ""
    
    override init() {}
    
    
    init(value: String, desc: String, categ: String, kind: String, currentDate: String) {
        self._value = value
        self._desc = desc
        self._categ = categ
        self._kind = kind
        self._currentDate = currentDate
    }
    
    
    required init(coder decoder: NSCoder) {
        
        if let valueObject = decoder.decodeObject(forKey: "value") as? String {
            _value = valueObject
        }
        if let descObject = decoder.decodeObject(forKey: "desc") as? String {
            _desc = descObject
        }
        if let categObject = decoder.decodeObject(forKey: "categ") as? String {
            _categ = categObject
        }
        if let kindObject = decoder.decodeObject(forKey: "kind") as? String {
            _kind = kindObject
        }
        if let dateObject = decoder.decodeObject(forKey: "currentDate") as? String {
            _currentDate = dateObject
        }
    }
    
    
    func encode(with coder: NSCoder) {
        
        coder.encode(_value, forKey: "value")
        coder.encode(_desc, forKey: "desc")
        coder.encode(_categ, forKey: "categ")
        coder.encode(_kind, forKey: "kind")
        coder.encode(_currentDate, forKey: "currentDate")
    }
    
    var value: String {
        get {
            return _value
        }
        set {
            _value = newValue
        }
    }
    var desc: String {
        get {
            return _desc
        }
        set {
            _desc = newValue
        }
    }
    var categ: String {
        get {
            return _categ
        }
        set {
            _categ = newValue
        }
    }
    var kind: String {
        get {
            return _kind
        }
        set {
            _kind = newValue
        }
    }
    var currentDate : String {
        get{
            return _currentDate
        }
        set {
            _kind = newValue
        }
}
}

