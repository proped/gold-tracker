//
//  HomeInteractor.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation

class HomeInteractor : HomeInteractorInputProtocol {
    
    internal var presenter: HomeInteractorOutputProtocol?
    internal var remoteDataManager: GoldPriceRemoteDataManager?
    
    // PRESERNTER -> INTERACTOR
    
    func fetchUpdateGoldPrice() {
        remoteDataManager?.fetch()
    }
    
    func loadPriceHistoryFromLocal() {        
        do {
            // alway clear old data record
            //try GoldPriceFileManager.remove()
            
            if let loadedData = try GoldPriceFileManager.load() {
                presenter?.didRetrieveHistoryData(goldPrices: loadedData)
            }
        } catch {
            print("no local file data")
        }
    }
    
    private func updateLocalFile(withData : GoldPrice) {
        do {
            if let goldPrices = try GoldPriceFileManager.load() {
                let sortedResult = goldPrices.insertAndSortByDESC(newData: withData)
                self.saveLocalFile(withData: sortedResult)
            }
            
        } catch {
            
            let goldPrices = GoldPrices(array: [withData])
            self.saveLocalFile(withData: goldPrices)
        }
    }
    
    private func saveLocalFile(withData : GoldPrices) {
        do {
            // save file
            try GoldPriceFileManager.save(goldPrices: withData)
        }
        catch {
            print("save file failed")
        }
    }

    
}

extension HomeInteractor : GoldPriceRemoteDataManagerOutputProtocol {
    
    func onSuccessFetchData(goldPrice: GoldPrice) {
        presenter?.didRetrieveData(goldPrice: goldPrice)
        
        // save data on local file
        updateLocalFile(withData: goldPrice)
        
    }
    
    func onFailFetchData(errorMsg: String) {
        presenter?.didReceivedError(withErrorMsg: errorMsg)
    }
}
