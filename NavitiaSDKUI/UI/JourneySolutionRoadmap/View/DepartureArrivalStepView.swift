//
//  DepartureArrivalStepView.swift
//  NavitiaSDKUI
//
//  Created by Flavien Sicard on 12/04/2018.
//  Copyright © 2018 kisio. All rights reserved.
//

import UIKit

class DepartureArrivalStepView: UIView {
    
    @IBOutlet var _view: UIView!
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    var _type: TypeStep?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        _setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var frame: CGRect {
        willSet {
            if let _view = _view {
                _view.frame.size = newValue.size
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        _setup()
    }
    
    private func _setup() {
        UINib(nibName: "DepartureArrivalStepView", bundle: bundle).instantiate(withOwner: self, options: nil)
        _view.frame = self.bounds
        addSubview(_view)
        
        _setupIcon()
    }
    
    private func _setupIcon() {
        iconLabel.text = Icon("location-pin").iconFontCode
        iconLabel.font = UIFont(name: "SDKIcons", size: 22)
        iconLabel.textColor = UIColor.white
    }
    
}

extension DepartureArrivalStepView {
    
    var type: TypeStep? {
        get {
            return _type
        }
        set {
            _type = newValue
            if newValue == .departure {
                self._view.backgroundColor = UIColor(red:0, green:0.73, blue:0.46, alpha:1.0)
                title = "Départ:"
            } else {
                self._view.backgroundColor = UIColor(red:0.69, green:0.01, blue:0.33, alpha:1.0)
                title = "Arrivée:"
            }
        }
    }
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            if let newValue = newValue {
                titleLabel.text = newValue
                self.layoutIfNeeded()
            }
        }
    }
    
    var information: String? {
        get {
            return informationLabel.text
        }
        set {
            if let newValue = newValue {
                informationLabel.text = newValue
            }
        }
    }
    
    var time: String? {
        get {
            return hourLabel.text
        }
        set {
            if let newValue = newValue {
                hourLabel.attributedText = NSMutableAttributedString()
                    .normal(newValue, color: UIColor.white,size: 12)
            }
        }
    }
    
}
