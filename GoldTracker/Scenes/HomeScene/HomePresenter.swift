//
//  HomePresenter.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    internal weak var view: HomeViewProtocol?
    internal var interactor: HomeInteractorInputProtocol?
    internal var wireFrame: HomeWireFrameProtocol?
    
    func viewDidLoad() {
        
        view?.showHomeLoading()
        
        interactor?.loadPriceHistoryFromLocal()
        interactor?.fetchUpdateGoldPrice()
        
    }
    
    func tappedRefreshButton() {
        view?.showHomeLoading()
        
        interactor?.fetchUpdateGoldPrice()
    }
    
    func swipeToReachAtPosition() {
        view?.showHomeLoading()
        
        interactor?.fetchUpdateGoldPrice()
    }
    
}


extension HomePresenter : HomeInteractorOutputProtocol {
    
    
    // INTERACTOR -> PRESENTER
    
    func didRetrieveData(goldPrice: GoldPrice) {
        
        view?.hideHomeLoading()
        
        view?.showGoldRatePrice(goldPrice: goldPrice)
    }
    
    func didRetrieveHistoryData(goldPrices: GoldPrices) {
        view?.showHistoryPrice(withData: goldPrices)
    }
    
    func didReceivedError(withErrorMsg: String) {
        view?.hideHomeLoading()
        
        view?.showErrorOnConnetcion(errMsg: withErrorMsg)
    }
    
    func didReceivedErrorWithNoInternetConnection() {
        view?.hideHomeLoading()
        
        view?.showErrorOnConnetcion(errMsg: "No internet connection")
    }
    
}
