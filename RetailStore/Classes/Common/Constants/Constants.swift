//
//  Constants.swift
//  RetailStore
//
//  Created by Saravanan on 19/05/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

//Enums
enum Category : Int {
    case Electronics = 1, Furniture
    
    func title() -> String {
        switch self {
        case .Electronics:
            return "Electronics"
        default:
            return "Furniture"
        }
    }
    
}

enum ScreenType {
    case List, Cart
    
    func title() -> String {
        switch self {
        case .List:
            return "Products"
        default:
            return "Cart"
        }
    }
    
}
