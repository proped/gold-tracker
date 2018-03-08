//
//  DoubleExtension.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//


import Foundation

extension Double {
    
    // not fix decimal point
    func applyCommaFormatInNumber (_ precisionDigi : Int = 2) -> String {
        if precisionDigi < 0 { return "\(self)" }
        
        let formatter                   = NumberFormatter()
        formatter.numberStyle           = .decimal
        formatter.maximumFractionDigits = precisionDigi;
        return formatter.string(from: NSNumber(value: self)) ?? ""
        
    }

    func toMYR() -> String {
        return "\(self.applyCommaFormatInNumber()) \(CurrencyUnit.MYR.value)"
    }
    
}
