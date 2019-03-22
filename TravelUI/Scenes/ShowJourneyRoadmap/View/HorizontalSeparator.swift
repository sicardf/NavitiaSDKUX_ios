//
//  HorizontalSeparator.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import UIKit

class HorizontalSeparator: UIView {
    
    // MARK: - UINib
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func instanceFromNib() -> HorizontalSeparator {
        return UINib(nibName: identifier, bundle: TravelUI.shared.bundle).instantiate(withOwner: nil, options: nil)[0] as! HorizontalSeparator
    }
}
