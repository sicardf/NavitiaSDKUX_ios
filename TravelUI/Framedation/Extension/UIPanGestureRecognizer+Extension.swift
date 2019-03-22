//
//  UIPanGestureRecognizer+Extension.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import UIKit

public extension UIPanGestureRecognizer {
    
    func isDown(theViewYouArePassing: UIView) -> Bool {
        return velocity(in: theViewYouArePassing).y > 0 ? true : false
    }
    
    func isUp(theViewYouArePassing: UIView) -> Bool {
        return velocity(in: theViewYouArePassing).y <= 0 ? true : false
    }
}
