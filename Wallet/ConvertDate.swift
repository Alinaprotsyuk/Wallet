//
//  File.swift
//  Wallet
//
//  Created by ITA student on 9/26/17.
//  Copyright © 2017 Alina Protsyuk. All rights reserved.
//

import Foundation


class ConvertDate{
    class func getStringFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    class func getDateFromString(string: String) -> Date{
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.date(from: string)!
    }
}



