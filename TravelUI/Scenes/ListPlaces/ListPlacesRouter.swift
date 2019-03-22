//
//  ListPlacesRouter.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import UIKit

@objc protocol ListPlacesRoutingLogic {
    
}

protocol ListPlacesDataPassing {
    
    var dataStore: ListPlacesDataStore? { get }
}

class ListPlacesRouter: NSObject, ListPlacesRoutingLogic, ListPlacesDataPassing {
    
    weak var viewController: ListPlacesViewController?
    var dataStore: ListPlacesDataStore?
}
