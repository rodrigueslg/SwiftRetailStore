//
//  DetailManager.swift
//  RetailStore
//
//  Created by Saravanan on 21/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation

class DetailManager {
    var dataStore = CoreDataStore.sharedInstance
 
    func saveMOC() {
        dataStore.save()
    }
    
    func newCartItem() -> CartItem {
        return dataStore.newCartItem()
    }

    func deleteObject(cartItem: CartItem) {
        dataStore.deleteObject(cartItem: cartItem)
    }
    
    func cartItemsFromStore(_ completion: (([CartItem]) -> Void)!) {
        dataStore.fetchEntriesWithPredicate({ entries in
            completion(entries)
        })
    }
    
    func save(cartItem: CartItem) {
        deleteSimilarCartItems(cartItem: cartItem)
        saveMOC()
    }
    
    func deleteSimilarCartItems(cartItem: CartItem) {
        dataStore.checkForSimilarCartItemAndDelete(cartItemToCheck: cartItem)
    }

    func delete(cartItem: CartItem) {
        dataStore.deleteObject(cartItem: cartItem)
    }
    
}
