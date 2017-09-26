//
//  File.swift
//  Wallet
//
//  Created by ITA student on 9/26/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation

func getTime(date: Date) -> String {
    //let date = Date()
    
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter.string(from: date)
}

