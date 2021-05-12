//
//  DetailInteractor.swift
//  RetailStore
//
//  Created by Saravanan on 21/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation

class DetailInteractor {
    var detailManager : DetailManager?
    
    init(detailManager: DetailManager) {
        self.detailManager = detailManager
    }
    
    func cartItemsFromStore(_ completion: (([CartItem]) -> Void)!) {
        detailManager?.cartItemsFromStore(completion)
    }

    func isProductAlreadyAdded(productId: Int16, withCompletionBlock completion: ((Bool) -> Void)!) {
        cartItemsFromStore({ cartItems in
            var added = false
            for item in cartItems {
                if item.productId == productId {
                    added = true
                    break
                }
            }
            completion(added)
        })
    }
    
    func save(toCart productId: Int16, withCompletionBlock completion: ((Bool) -> Void)!) {
        isProductAlreadyAdded(productId: productId, withCompletionBlock: { added in
            if !added {
                let newCartItem = self.detailManager?.newCartItem()
                newCartItem?.productId = productId
                if let cartItem = newCartItem {
                    self.detailManager?.save(cartItem: cartItem)
                }
            }
            completion(!added)
        })
    }
    
    func delete(cartItem: CartItem) {
        detailManager?.delete(cartItem: cartItem)
    }
    
    func deleteSimilarCartItems(cartItem: CartItem) {
        detailManager?.deleteSimilarCartItems(cartItem: cartItem)
    }
    

}
