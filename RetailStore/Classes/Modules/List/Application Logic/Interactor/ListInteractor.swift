//
//  ListInteractor.swift
//  RetailStore
//
//  Created by Saravanan on 10/06/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import RxSwift

class ListInteractor {
    
    let dataManager : ListDataManager
    
    var products: Variable<[Product]> = Variable([])
    
    init(dataManager: ListDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchProductsFromStore() {
        
        self.products.value.removeAll()
        
        for prod in dataManager.productsArray {
            self.products.value.append(prod)
        }
        
    }
    
}
