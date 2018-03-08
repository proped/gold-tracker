//
//  HomeView.swift
//  GoldTracker
//
//  Created by Nattapon on 5/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation
import UIKit

class HomeView : UIViewController {
    
    internal var presenter : HomePresenterProtocol?
    
    
    @IBOutlet weak var pullToRefreshLabel: UILabel!
    
    @IBOutlet weak var startImageView: UIImageView!
    @IBOutlet weak var lastUpdatedTimeLabel: UILabel!
    
    @IBOutlet weak var buyRateLabel: UILabel!
    @IBOutlet weak var sellRateLabel: UILabel!
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var historyTableView: UITableView!
    
    // control value
    private var isStillLoading : Bool   = false
    private var shouldRefresh : Bool    = false
    
    // model
    var goldRates : GoldPrices = GoldPrices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func setUpdateTimeLabel(withDatetime: Date) {
        lastUpdatedTimeLabel.text = "Last updated at \(withDatetime.toDateString("HH:mm:ss"))"
    }
    
    private func showErrorOnLabel(withError: String) {
        lastUpdatedTimeLabel.text = withError
    }
    
    private func setBuyRateLabel(withPrice: Double) {
        buyRateLabel.text = withPrice.applyCommaFormatInNumber(2) + " \(CurrencyUnit.MYR.value)"
    }
    
    private func setSellRateLabel(withPrice: Double) {
        sellRateLabel.text = withPrice.applyCommaFormatInNumber(2) + " \(CurrencyUnit.MYR.value)"
    }
    
    private func startRotateStarWithAnimation() {
        isStillLoading = true
        startImageView?.rotate360Degrees()
    }
    
    private func stopRotateStarWithAnimation() {
        
        isStillLoading = false
        startImageView?.stopRotate()
    }
    
    // ### Button Action ###
    
    @IBAction func refreshButtontapped(_ sender: UIButton) {
        
        // prevent form dupicate call on api
        if isStillLoading { return }
            
        presenter?.tappedRefreshButton()
    }
    
    @IBAction func graphButtontapped(_ sender: UIButton) {
        
        // prevent show graph when loading data
        if isStillLoading { return }
        
        //presenter?.tappedRefreshButton()
    }
    
}

extension HomeView : HomeViewProtocol {
    func showHomeLoading() {
        startRotateStarWithAnimation()
    }
    
    func hideHomeLoading() {
        stopRotateStarWithAnimation()
    }
    
    func showHistoryPrice(withData: GoldPrices) {
        goldRates = withData
        
        historyTableView.reloadData()
    }
    
    func showErrorOnConnetcion(errMsg: String) {
        showErrorOnLabel(withError: errMsg)
    }
    
    func showGoldRatePrice(goldPrice: GoldPrice) {
        setBuyRateLabel(withPrice: goldPrice.buyRateRM)
        setSellRateLabel(withPrice: goldPrice.sellRateRM)
        setUpdateTimeLabel(withDatetime: goldPrice.timestamp)
        
        // append new and reload data
        let newRatePrices = goldRates.insertAndSortByDESC(newData: goldPrice)
        showHistoryPrice(withData: newRatePrices)
    }
    
}

extension HomeView : UIScrollViewDelegate {
    
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            
            if isStillLoading { return }
            
            if scrollView != contentScrollView { return }
            
            let scrollViewOffsetY   : CGFloat  = scrollView.contentOffset.y
    
            let refershOffsetY      : CGFloat  = -100
            let staticOffsetY       : CGFloat  = -10
            let labelOffsetX        : CGFloat  = pullToRefreshLabel.frame.origin.x

            // set visible on pull to refresh label
            pullToRefreshLabel.isHidden     = false
            
            if (scrollViewOffsetY < refershOffsetY) {
                pullToRefreshLabel.text         = "Release to refresh"
                pullToRefreshLabel.frame.origin = CGPoint(x: labelOffsetX, y: staticOffsetY)
                
                // trigger refeash action
                shouldRefresh                   = true
            }
            else if (scrollViewOffsetY >= refershOffsetY) && (scrollViewOffsetY <= 0){
                let calculateOffsetY = abs(scrollViewOffsetY) + (refershOffsetY + staticOffsetY)
                
                pullToRefreshLabel.frame.origin = CGPoint(x: labelOffsetX, y: calculateOffsetY)
            }
    
        }
    
    // not use for now
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        // allow delegate only for content scrollview
        if scrollView != contentScrollView { return }

        // reset pull to refresh label
        pullToRefreshLabel.isHidden = true
        pullToRefreshLabel.text     = "Pull to refresh"
        
        // fecth new data
        if shouldRefresh {
            shouldRefresh = false
            presenter?.swipeToReachAtPosition()
        }
        
    }
}

// MARK: ### UITableViewDelegate ###

extension HomeView : UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let _cell = cell as? HistoryTableViewCell {
         
            let data = goldRates[indexPath.row]
            _cell.setBuyRate(rate: data.buyRateRM)
            _cell.setSellRate(rate: data.sellRateRM)
            _cell.setDatetime(datetime: data.timestamp)
        }
        
        
    }
    
    
}

// MARK: ### UITableViewDataSource ###

extension HomeView : UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // show empty data
        if goldRates.count <= 0 { return 1 }
        
        return goldRates.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // show empty data
        if goldRates.count <= 0 {
            return tableView.dequeueReusableCell(withIdentifier: "NoHistoryTableViewCell", for: indexPath)
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath)
        
        
    }
    
}
