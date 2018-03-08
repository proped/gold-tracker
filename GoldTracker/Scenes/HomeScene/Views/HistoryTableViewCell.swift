//
//  HistoryTableViewCell.swift
//  GoldTracker
//
//  Created by Nattapon on 7/3/2561 BE.
//  Copyright © 2561 Nattapon. All rights reserved.
//

import Foundation
import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var buyRateLabel: UILabel!
    @IBOutlet weak var sellRateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func setBuyRate(rate: Double) {
        buyRateLabel.text = rate.applyCommaFormatInNumber(2) + " RM"
    }
    
    func setSellRate(rate: Double) {
        sellRateLabel.text = rate.applyCommaFormatInNumber(2) + " RM"
    }
    
    func setDatetime(datetime: Date) {
        dateLabel.text = datetime.toDateString("dd MMM yyyy")
        timeLabel.text = datetime.toDateString("HH:mm:ss")
    }
}
