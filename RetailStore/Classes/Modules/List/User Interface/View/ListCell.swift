//
//  ListCell.swift
//  RetailStore
//
//  Created by Saravanan on 20/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import UIKit

class ListCell: UITableViewCell {
    
    static let Identifier = "ListCell"
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet internal var productImageView: UIImageView!
    var screenType = ScreenType.List

    func configureWithProduct(product: Product) {
        guard let productName = product.name else {
            return
        }

        nameLabel.text = productName
        productImageView.image = UIImage(named: product.imageName)
        if screenType == .Cart {
            priceLabel.isHidden = false
            if let price = product.price {
                priceLabel.text = "Rs. \(price)"
            }
        }
    }
    
}
