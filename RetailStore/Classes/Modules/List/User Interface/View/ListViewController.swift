//
//  ListViewController.swift
//  RetailStore
//
//  Created by Saravanan on 20/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

var ListCellIdentifier = "ListCell"

class ListViewController : UIViewController, UITableViewDelegate, Cart {
    var totalPrice: Int = 0
    var eventHandler : ListPresenter?
    var cartItems = [CartItem]()
    var screenType = ScreenType.List

    var dataSource: RxTableViewSectionedReloadDataSource<SectionModel<NSNumber, Product>>!
    var dataVariableArray: Variable<[SectionModel<NSNumber, Product>]> = Variable([])

    @IBOutlet weak var tableView : UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateCartCount()
        eventHandler?.updateView(screenType: screenType)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configureView() {
        //Title
        navigationItem.title = screenType.title()
        
        //Cart Button Configuration
        configureCart(in: self)
        
        //Table View Configuration
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<NSNumber, Product>>(configureCell: { (_, tv, indexPath, product) in
            let cell = tv.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
            cell.screenType = self.screenType
            cell.configureWithProduct(product: product)
            
            return cell
        })
        dataSource.canEditRowAtIndexPath = { dataSource, indexPath in
            true//self.canEditCell()
        }
        
//        dataSource.configureCell = { (_, tv, indexPath, product) in
//            let cell = tv.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
//            cell.screenType = self.screenType
//            cell.configureWithProduct(product: product)
//
//            return cell
//        }
        
        dataSource.titleForHeaderInSection = { dataSource, sectionIndex in
            return Category(rawValue: dataSource[sectionIndex].model.intValue)?.title()
        }
        
        self.dataSource = dataSource
        
        dataVariableArray.asObservable()
            .bindTo(tableView.rx.items(dataSource: dataSource))
            .addDisposableTo(disposeBag)
        
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { indexPath, model in
                //Navigate to Detail screen from here
                self.eventHandler?.showDetail(product: model)
            })
            .addDisposableTo(disposeBag)

        tableView.rx
            .itemDeleted
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { indexPath, model in
                self.deleteCartItem(withProduct: model)
            })
            .addDisposableTo(disposeBag)
        
        tableView.rx
            .setDelegate(self)
            .addDisposableTo(disposeBag)
        
    }
    
    func deleteCartItem(withProduct product: Product) {
        eventHandler?.deleteCartItem(withProductId: product.productId.int16Value)
        updateCartCount()
        eventHandler?.updateView(screenType: screenType)

    }
    
    func canEditCell() -> Bool {
        if self.screenType == .Cart {
            return true
        }
        return false
    }
    
    func totalCellView() -> UIView {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TotalCell") as! TotalCell
        cell.configure(withPrice: self.totalPrice)
        return cell
    }
    
    //To prevent swipe to delete behavior
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if screenType == .Cart {
            return true
        }
        return false
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if screenType == .Cart {
            return .delete
        }
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //MARK:
    //MARK: Cart Protocol Methods
    func cartIconTapped() {
        //Tapped
        navigate(toCart: self)
    }
    
    //MARK:
    //MARK: Utility Methods
    func calculateTotalPrice(sectioned data: [SectionModel<NSNumber, Product>]) -> Int {
        var total = 0
        for section in data {
            for product in section.items {
                total += product.price.intValue
            }
        }
        return total
    }
    
    //MARK:
    //MARK: Other Methods
    func showProducts(sectioned data: [SectionModel<NSNumber, Product>]) {
        if screenType == ScreenType.Cart {
            totalPrice = calculateTotalPrice(sectioned: data)
            tableView.tableFooterView = totalCellView()
        }
        dataVariableArray.value = data
    }
    
    func updatedCartItems(_ cartItems: [CartItem]) {
        self.cartItems = cartItems
        updateCartCount()
    }
    
    
}
