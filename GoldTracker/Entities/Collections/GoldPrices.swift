//
//  GoldPrices.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation

class GoldPrices : Codable {
    var lists : [GoldPrice] = []
    
    var first : GoldPrice? { get { return lists.first } }
    var count : Int { get { return lists.count } }
    subscript(index: Int) -> GoldPrice { get { return lists[index] } }
    
    init(){ }
    init(array: [GoldPrice]) { self.lists = array }
    
  
    func sortByDESC() -> GoldPrices {
        let result = lists.sorted { (gp1, gp2) -> Bool in
            return gp1.timestamp > gp2.timestamp
        }
        
        return GoldPrices(array: result)
    }
    
    func insertAndSortByDESC(newData: GoldPrice) ->GoldPrices {
        lists.append(newData)
        return sortByDESC()
    }
}
