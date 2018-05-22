//
//  BookDelegate.swift
//  NavitiaSDKUI
//
//  Copyright © 2018 kisio. All rights reserved.
//

import UIKit

@objc public protocol BookTicketDelegate {
    
    func onDisplayCreateAccount()
    func onDisplayConnectionAccount()
    func onDisplayTicket()
    func onDismissBookTicket()
    
}
