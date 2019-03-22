//
//  TravelUserDefaultsManager.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import Foundation

open class TravelUserDefaultsManager {
    
    public static let SHOW_REDIRECTION_DIALOG_PREF_KEY = "TravelShowRedirectionDialog"
    public static let SHOW_REDIRECTION_DIALOG_DEF_VALUE = true
    
    public static func resetUserDefaults() {
        UserDefaults.standard.set(SHOW_REDIRECTION_DIALOG_DEF_VALUE, forKey: SHOW_REDIRECTION_DIALOG_PREF_KEY)
        UserDefaults.standard.synchronize()
    }
    
    public static func saveUserDefault(key: String, value: Any) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
