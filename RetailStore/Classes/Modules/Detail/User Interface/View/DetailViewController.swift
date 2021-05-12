//
//  DetailViewController.swift
//  RetailStore
//
//  Created by Saravanan on 21/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController, Cart {
    var eventHandler : DetailPresenter?
    
    var product: Product?
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var priceLabel : UILabel!
    @IBOutlet weak var imageView : UIImageView!
    @IBOutlet weak var addToCartButton : UIButton!

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCartCount()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func configureView() {
        navigationItem.title = "Product Detail"
        
        //Cart Button Configuration
        configureCart(in: self)

        //Binding data
        nameLabel.text = product?.name
        priceLabel.text = "Rs. " + (product?.price.stringValue)!
        if let imageName = product?.imageName {
            imageView.image = UIImage(named: imageName)
        }
        
    }
    
    
    //MARK:
    //MARK: Actions
    @IBAction func addToCartButtonTapped(_ sender: Any) {
        if let productId = product?.productId {
            eventHandler?.add(toCart: productId)
            addToCartButton.isUserInteractionEnabled = false
            addToCartButton.setTitle("Added!", for: .normal)
        }
    }
    
    //MARK:
    //MARK: Cart Protocol Methods
    func cartIconTapped() {
        //Tapped
        navigate(toCart: self)
    }
    
}
