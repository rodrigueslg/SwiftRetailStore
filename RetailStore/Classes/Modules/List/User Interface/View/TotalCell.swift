//
//  TotalCell.swift
//  RetailStore
//
//  Created by Saravanan on 03/06/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import UIKit

class TotalCell: UITableViewCell {
    
    static let Identifier = "TotalCell"
    
    @IBOutlet private var totalPriceLabel: UILabel!
    
    func configure(withPrice price: Int) {
        totalPriceLabel.text = "Rs. \(price)"
    }
    
}
