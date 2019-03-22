//
//  StepByStepItemVIew.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import UIKit

class StepByStepItemView: UIView {
    
    @IBOutlet weak var directionIconImageView: UIImageView!
    @IBOutlet weak var directionInstructionLabel: UILabel!
    
    internal var icon: String? {
        didSet {
            guard let icon = icon else {
                return
            }
            
            directionIconImageView.image = UIImage(named: icon, in: TravelUI.shared.bundle, compatibleWith: nil)
        }
    }
    
    internal var instruction: String? {
        didSet {
            directionInstructionLabel.text = instruction
        }
    }
    
    // MARK: - UINib
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func instanceFromNib() -> StepByStepItemView {
        return UINib(nibName: identifier, bundle: TravelUI.shared.bundle).instantiate(withOwner: nil, options: nil)[0] as! StepByStepItemView
    }
}
