//
//  GoldPriceFileManager.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation
import Disk

class GoldPriceFileManager {
    
    static let fileName             = "gold_prices.json"
    static let fileStoredDirectory  = Disk.Directory.caches
    static let filePath             = "price_history"
    
    static func isExist() -> Bool {
        let path = filePath + "/" + fileName
        return Disk.exists(path, in: self.fileStoredDirectory)
    }
    
    static func save(goldPrices: GoldPrices) throws -> () {
        let path = filePath + "/" + fileName
        do {
            try Disk.save(goldPrices, to: self.fileStoredDirectory, as: path)
        }
        catch let error as NSError {
            throw FileManagerError.saveFileFailed(error: error)
        }
    }
    
    static func load() throws -> GoldPrices? {
        let path = filePath + "/" + fileName
        do {
            let retrievedData = try Disk.retrieve(path, from: self.fileStoredDirectory , as: GoldPrices.self)
            return retrievedData
        }
        catch let error {
            throw FileManagerError.loadFileFailed(error: error)
        }
    }
    
    static func remove() throws -> () {
        let path = filePath + "/" + fileName
        do {
            try Disk.remove(path, from: self.fileStoredDirectory)
        }
        catch let error {
            throw FileManagerError.removeFileFailed(error: error)
        }
    }

    
}
