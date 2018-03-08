//
//  HomeWireFrame.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation
import UIKit

class HomeWireFrame: HomeWireFrameProtocol {
    
    class func loadFromStoryborad() -> HomeView {
        let storyboard    = UIStoryboard(name: "Home", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "HomeView") as! HomeView
    }
    
    class func createModule() -> HomeView {
        
        let view = HomeWireFrame.loadFromStoryborad()
        
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol & GoldPriceRemoteDataManagerOutputProtocol = HomeInteractor()
        let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
        
        let remoteDataManager                       = GoldPriceRemoteDataManager()
        view.presenter                              = presenter
        presenter.view                              = view
        presenter.wireFrame                         = wireFrame
        presenter.interactor                        = interactor
        interactor.presenter                        = presenter
        interactor.remoteDataManager                = remoteDataManager
        
        remoteDataManager.fetchRemoteRequestHandler = interactor
        
        
        return view
        
    }
    
}
