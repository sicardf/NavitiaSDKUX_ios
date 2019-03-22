//
//  UIViewController+Extension.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import Foundation

extension StopDateTime {
    
    func selectLinks(type: String) -> [LinkSchema] {
        var selectLinks = [LinkSchema]()
        
        guard let links = self.links else {
            return selectLinks
        }
        
        for link in links {
            if link.type == type {
                selectLinks.append(link)
            }
        }
        
        return selectLinks
    }
}
