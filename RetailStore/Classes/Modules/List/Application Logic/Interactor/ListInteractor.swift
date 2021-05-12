//
//  ListInteractor.swift
//  RetailStore
//
//  Created by Saravanan on 19/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

class ListInteractor {
    
    let dataManager : ListDataManager
    var disposeBag: DisposeBag = DisposeBag()
    
    var cartItems: Variable<[CartItem]> = Variable([])
    var products: Variable<[Product]> = Variable([])
    
    init(dataManager: ListDataManager) {
        self.dataManager = dataManager
    }
    
    func fetchCartItemsFromStore() -> Observable<[CartItem]> {
        self.cartItems.value.removeAll()
        for item in dataManager.cartItems {
            self.cartItems.value.append(item)
        }
        
        return Observable.create { observer in
            observer.onNext(self.cartItems.value)
            return Disposables.create()
        }
    }

    func fetchProductsFromStore() -> Observable<[Product]> {
        self.products.value.removeAll()
        for prod in dataManager.productsArray {
            self.products.value.append(prod)
        }
        
        return Observable.create { observer in
            observer.onNext(self.products.value)
            return Disposables.create()
        }
    }
    
    //Utility Methods
    func cartItemProducts(cartItems: [CartItem]) -> [Product] {
        var filteredProducts = [Product]()
        for item in cartItems {
            let fetchedProducts = filterProducts(data: dataManager.productsArray, withProductId: item.productId)
            if fetchedProducts.count > 0 {
                filteredProducts.append(fetchedProducts[0])
            }
        }
        return filteredProducts
    }
    
    func sectionedData(data: [Product]) -> [SectionModel<NSNumber, Product>] {
        
        var sectioned = [SectionModel<NSNumber, Product>]()
        for index in Category.Electronics.rawValue...Category.Furniture.rawValue {
            let filteredProducts = filterProducts(data: data, withCategoryId: index)
            let sectionModel = SectionModel(model: NSNumber(value: index), items: filteredProducts)
            sectioned.append(sectionModel)
        }
        
        return removeEmptySections(sectionArray: sectioned)
    }
    
    func removeEmptySections(sectionArray: [SectionModel<NSNumber, Product>]) -> [SectionModel<NSNumber, Product>]  {
        var filteredSections = [SectionModel<NSNumber, Product>]()
        for sectionModel in sectionArray {
            if sectionModel.items.count > 0 {
                filteredSections.append(sectionModel)
            }
        }
        return filteredSections
    }
    
    func filterProducts(data: [Product], withCategoryId categoryId: Int) -> [Product] {
        let returnValue = data.filter({
            return $0.categoryId.intValue == categoryId
        })
        return returnValue
    }
    
    func filterProducts(data: [Product], withProductId productId: Int16) -> [Product] {
        let returnValue = data.filter({
            return $0.productId.int16Value == productId
        })
        return returnValue
    }

    func deleteCartItem(withProductId productId: Int16) {
        dataManager.deleteCartItem(withProductId: productId)
    }

}
