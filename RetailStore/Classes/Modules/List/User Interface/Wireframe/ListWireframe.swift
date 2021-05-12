//
//  ListWireframe.swift
//  RetailStore
//
//  Created by Saravanan on 20/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation
import UIKit

let ListViewControllerIdentifier = "ListViewController"

class ListWireframe : NSObject {
    var listPresenter : ListPresenter?
    var rootWireframe : RootWireframe?
    var listViewController : ListViewController?

    func configuredListViewController() -> ListViewController {
        let viewController = listViewControllerFromStoryboard()
        viewController.eventHandler = listPresenter
        listViewController = viewController
        listPresenter?.userInterface = viewController
        return viewController
    }
    
    func presentListInterfaceFromWindow(_ window: UIWindow) {
        let viewController = configuredListViewController()
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    func navigate(toCart fromViewController: UIViewController) {
        let cartViewController = configuredListViewController()
        cartViewController.screenType = .Cart
        fromViewController.navigationController?.pushViewController(cartViewController, animated: true)
    }
    
    func navigateToDetail(withProduct product: Product) {
        let detailWireframe = DetailWireframe()
        let detailManager = DetailManager()
        let detailInteractor = DetailInteractor(detailManager: detailManager)
        let detailPresenter = DetailPresenter()
        detailPresenter.detailInteractor = detailInteractor
        detailPresenter.detailWireframe = detailWireframe
        detailWireframe.detailPresenter = detailPresenter
        detailWireframe.presentDetailInterface(fromViewController: listViewController!, withProduct: product)
    }

    func updateCartCount(cartCount: Int) {
        //Update Cart Count on Cart Icon in the Navigation bar here
    }
    
    func listViewControllerFromStoryboard() -> ListViewController {
        let storyboard = mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ListViewControllerIdentifier) as! ListViewController
        return viewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard
    }
    
}
