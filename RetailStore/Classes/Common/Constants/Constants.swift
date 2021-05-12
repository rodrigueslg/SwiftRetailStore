//
//  Constants.swift
//  RetailStore
//
//  Created by Saravanan on 10/06/17.
//  Copyright © 2017 Saravanan. All rights reserved.
//

import Foundation

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
