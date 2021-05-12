//
//  Presenter.swift
//  RetailStore
//
//  Created by Saravanan on 20/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources

class ListPresenter {
    var listWireframe : ListWireframe?
    var listInteractor : ListInteractor?
    var userInterface : ListViewController?
    let disposeBag = DisposeBag()
    
    func updateUserInterface(with cartItems: [CartItem]) {
        userInterface?.updatedCartItems(cartItems)
    }
    
    func updateUserInterface(with products: [SectionModel<NSNumber, Product>]) {
        userInterface?.showProducts(sectioned: products)
    }

    func updateView(screenType: ScreenType) {
        //Cart Items
        listInteractor?.fetchCartItemsFromStore()
            .asObservable().subscribe( {onNext in
                guard let cartItems = self.listInteractor?.cartItems else {
                    return
                }
                self.updateUserInterface(with: cartItems.value)
                if let filteredProducts = self.listInteractor?.cartItemProducts(cartItems: cartItems.value) {
                    if let sectioned = self.listInteractor?.sectionedData(data: filteredProducts) {
                        if (screenType == .Cart) {
                            self.updateUserInterface(with: sectioned)
                        }
                    }
                }
            })
            .addDisposableTo(disposeBag)

        //Products
        listInteractor?.fetchProductsFromStore()
        .asObservable().subscribe( {onNext in
            guard let products = self.listInteractor?.products else {
                return
            }
            if let sectioned = self.listInteractor?.sectionedData(data: products.value) {
                if (screenType == .List) {
                    self.updateUserInterface(with: sectioned)
                }
            }
        })
        .addDisposableTo(disposeBag)
    }
    
    func showDetail(product: Product) {
        listWireframe?.navigateToDetail(withProduct: product)
    }
    
    func deleteCartItem(withProductId productId: Int16) {
        listInteractor?.deleteCartItem(withProductId: productId)
    }
    
}
