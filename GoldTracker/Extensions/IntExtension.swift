//
//  IntExtension.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//


import Foundation

extension Int {
    
    // not fix decimal point
    func applyCommaFormatInNumber (_ precisionDigi : Int = 0) -> String {
        if precisionDigi < 0 { return "\(self)" }
        
        let formatter                   = NumberFormatter()
        formatter.numberStyle           = .decimal
        formatter.maximumFractionDigits = precisionDigi;        
        return formatter.string(from: NSNumber(value: self)) ?? ""
        
    }
    
    func applySuffix(_ name : String) -> String {
        return name + (self > 1 ? "s" : "")
    }
    
}

