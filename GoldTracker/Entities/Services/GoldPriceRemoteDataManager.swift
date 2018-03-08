//
//  GoldPriceRemoteDataManager.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol GoldPriceRemoteDataManagerInputProtocol {
    func fetch()
}

protocol GoldPriceRemoteDataManagerOutputProtocol {
    func onSuccessFetchData(goldPrice: GoldPrice)
    func onFailFetchData(errorMsg: String)
}

class GoldPriceRemoteDataManager: GoldPriceRemoteDataManagerInputProtocol {
    var fetchRemoteRequestHandler: GoldPriceRemoteDataManagerOutputProtocol?
    
    func fetch() {

        let url = Profile.hostUrl + "/spot_price.json"
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          headers: nil)
            .responseJSON(completionHandler: { (data) in
                
                let value   = data.result.value!
                let json    = JSON(value)
                if let jsonParse = json.rawString(){
                    if let respObjParse = GoldPrice(JSONString: jsonParse){
                        self.fetchRemoteRequestHandler?.onSuccessFetchData(goldPrice: respObjParse)
                        return
                    }
                }
                
                self.fetchRemoteRequestHandler?.onFailFetchData(errorMsg: "Fetch fail")

            })
    }
}
