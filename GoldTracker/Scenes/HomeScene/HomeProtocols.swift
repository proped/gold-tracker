//
//  HomeProtocols.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation

protocol HomeViewProtocol: class {
    var presenter: HomePresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showHomeLoading()
    func hideHomeLoading()    
    func showHistoryPrice(withData: GoldPrices)
    func showGoldRatePrice(goldPrice: GoldPrice)
    func showErrorOnConnetcion(errMsg:String)
    
}

protocol HomeWireFrameProtocol: class {
    
    static func createModule() -> HomeView
    
    // PRESENTER -> WIREFRAME

}

protocol HomePresenterProtocol: class {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorInputProtocol? { get set }
    var wireFrame: HomeWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
    func tappedRefreshButton()
    
    func swipeToReachAtPosition()    
    
    
}

protocol HomeInteractorInputProtocol: class {
    
    var presenter: HomeInteractorOutputProtocol? { get set }
    
    var remoteDataManager: GoldPriceRemoteDataManager? { get set }
    // PRESERNTER -> INTERACTOR
    func fetchUpdateGoldPrice()
    func loadPriceHistoryFromLocal()

    
}

protocol HomeInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didRetrieveData(goldPrice: GoldPrice)
    func didRetrieveHistoryData(goldPrices: GoldPrices)
    func didReceivedError(withErrorMsg: String)
    func didReceivedErrorWithNoInternetConnection()
    
}
