//
//  DetailPresenter.swift
//  RetailStore
//
//  Created by Saravanan on 21/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class DetailPresenter {
    var detailInteractor : DetailInteractor?
    var detailWireframe : DetailWireframe?
    var userInterface : DetailViewController?
    var disposeBag: DisposeBag = DisposeBag()
    
    
    func add(toCart productId: NSNumber) {
        detailInteractor?.save(toCart: productId.int16Value, withCompletionBlock: { saved in
            if saved {
                self.detailWireframe?.displayAlert(title: "Added", message: "Product added to the Cart")
                self.userInterface?.updateCartCount()
            }
            else {
                self.detailWireframe?.displayAlert()
            }
        })
    }
    
}
