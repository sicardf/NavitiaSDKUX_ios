//
//  HorizontalSeparator.swift
//  NavitiaSDKUI
//
//  Copyright © 2018 kisio. All rights reserved.
//

import Foundation
import UIKit

class HorizontalSeparator: UIView {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func instanceFromNib() -> HorizontalSeparator {
        return UINib(nibName: identifier, bundle: NavitiaSDKUI.shared.bundle).instantiate(withOwner: nil, options: nil)[0] as! HorizontalSeparator
    }
}