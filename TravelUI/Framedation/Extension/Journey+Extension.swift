//
//  Journey+Extension.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import Foundation

extension Journey {
    
    var isRidesharing: Bool {
        get {
            if let ridesharingDistance = distances?.ridesharing, ridesharingDistance > 0 {
                return true
            }
            
            return false
        }
    }
}
