//
//  GoldPrice.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation
import ObjectMapper


struct GoldPrice : Codable {
    var buyRateRM   : Double    = 0
    var sellRateRM  : Double    = 0
    var timestamp   : Date      = Date()
    
    init() {
        
    }
    
}

extension GoldPrice : Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        
        let customDateFormatTransform = CustomDateFormatTransform(formatString: "yyyy'-'MM'-'dd'T'HH':'mm':'ss.SSSZZZ")
        
        buyRateRM           <- map["data.buy"]
        sellRateRM          <- map["data.sell"]
        timestamp           <- (map["data.timestamp"],customDateFormatTransform)
        
    }
}
