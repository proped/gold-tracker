//
//  CurrencyUnit.swift
//  GoldTracker
//
//  Created by Nattapon on 6/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation

enum CurrencyUnit : String {
   
    case MYR = "RM"
    
    var value : String {
        get {
            return self.rawValue
        }
    }
}
