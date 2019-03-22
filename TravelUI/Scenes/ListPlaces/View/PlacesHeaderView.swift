//
//  PlacesHeaderView.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import UIKit

class PlacesHeaderView: UIView {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    internal var title: String? {
        get {
            return titleLabel.text
        }
        set {
            guard let title = newValue else {
                return
            }
            
            titleLabel.attributedText = NSMutableAttributedString().bold(title, color: Configuration.Color.main, size: 11)
        }
    }
    
    // MARK: - UINib
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func instanceFromNib() -> PlacesHeaderView {
        return UINib(nibName: identifier, bundle: TravelUI.shared.bundle).instantiate(withOwner: nil, options: nil)[0] as! PlacesHeaderView
    }
}
