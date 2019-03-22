//
//  Message+Extension.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import Foundation

extension Message {
    
    public var escapedText: String? {
        guard var text = self.text else {
            return ""
        }
        
        text = text.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        return text.replacingOccurrences(of: "\n", with: "")
    }
}
