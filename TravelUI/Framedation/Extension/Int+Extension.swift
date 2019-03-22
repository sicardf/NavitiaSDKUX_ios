//
//  Int+Extension.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import Foundation

extension Int {
    
    func toDateFormat() -> String {
        return self < 10 ? String(format: "0%d", self) : String(self)
    }
}
