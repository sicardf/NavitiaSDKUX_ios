//
//  Configuration.swift
//  RenderTest
//
//  Created by Thomas Noury on 02/08/2017.
//  Copyright © 2017 Kisio. All rights reserved.
//

import UIKit

public struct Configuration {
    public struct MetricConfiguration {
        let space = 4
        public var radius = 5
        let marginS = 4
        let margin = 8
        let marginL = 16
        let textS = 13
        let text = 17
        let timeFormat = "HH:mm"
        let longDateFormat = "EEE d MMM - HH:mm"
    }
    
    public struct ColorConfiguration {
        public var primary = UIColor(red:0.40, green:0.40, blue:0.40, alpha:1.0) {
            didSet {
                self.primaryText = contrastColor(color: self.primary, brightColor: self.brightText, darkColor: self.darkText)
            }
        }
        var primaryText = UIColor.white
        public var secondary = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0) {
            didSet {
                self.secondaryText = contrastColor(color: self.secondary, brightColor: self.brightText, darkColor: self.darkText)
            }
        }
        var secondaryText = UIColor.white
        public var tertiary = UIColor(red:0.25, green:0.58, blue:0.56, alpha:1.0) {
            didSet {
                self.tertiaryText = contrastColor(color: self.tertiary, brightColor: self.brightText, darkColor: self.darkText)
            }
        }
        var tertiaryText = UIColor.white
        public var brightText = UIColor.white
        public var darkText = UIColor.black
        let white = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        let lighterGray = UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
        let lightGray = UIColor(red:0.80, green:0.80, blue:0.80, alpha:1.0)
        let gray = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
        let darkGray = UIColor(red:0.25, green:0.25, blue:0.25, alpha:1.0)
        let darkerGray = UIColor(red:0.12, green:0.12, blue:0.12, alpha:1.0)
        public var origin = UIColor(red:0, green:0.73, blue:0.46, alpha:1.0)
        public var destination = UIColor(red:0.69, green:0.01, blue:0.33, alpha:1.0)
    }
    
    let iconFontCodes:[String: String] = [
        "address": "\u{ea02}",
        "administrative-region": "\u{ea03}",
        "air": "\u{ea04}",
        "arrow-details-down": "\u{ea05}",
        "arrow-details-up": "\u{ea06}",
        "arrow-direction-left": "\u{ea07}",
        "arrow-direction-right": "\u{ea08}",
        "arrow-direction-straight": "\u{ea09}",
        "arrow-left-long": "\u{ea0a}",
        "arrow-right-long": "\u{ea0b}",
        "arrow-right": "\u{ea0c}",
        "bike": "\u{ea0d}",
        "ferry": "\u{ea0e}",
        "bss": "\u{ea0f}",
        "bus": "\u{ea10}",
        "calendar": "\u{ea11}",
        "car": "\u{ea12}",
        "clock": "\u{ea13}",
        "coach": "\u{ea14}",
        "destination": "\u{ea15}",
        "direction": "\u{ea16}",
        "edit": "\u{ea17}",
        "funicular": "\u{ea18}",
        "geolocation": "\u{ea19}",
        "home": "\u{ea1a}",
        "location-pin": "\u{ea15}",
        "line-diagram-stop": "\u{e900}",
        "metro": "\u{ea1b}",
        "notice": "\u{ea1c}",
        "origin": "\u{ea1d}",
        "poi": "\u{ea1e}",
        "realtime": "\u{ea1f}",
        "stop": "\u{ea21}",
        "localtrain": "\u{ea23}",
        "rapidtransit": "\u{ea23}",
        "longdistancetrain": "\u{ea23}",
        "tramway": "\u{ea24}",
        "walking": "\u{ea25}",
        "work": "\u{ea26}",
        "circle-filled": "\u{ea27}",
        "circle": "\u{ea28}",
        "disruption-blocking": "\u{ea29}",
        "disruption-nonblocking": "\u{ea2a}",
        "disruption-information": "\u{ea2b}",
        "ridesharing": "\u{ea2c}"
    ]
    
    public var colors = ColorConfiguration()
    public var metrics = MetricConfiguration()
    public var token = ""
}

var config = Configuration()

// Expose outside bundle
public class NavitiaSDKUXConfig: NSObject {
    public static func getToken() -> String {
        return config.token
    }
    
    public static func setToken(token: String) {
        config.token = token
    }
    
    public static func getTertiaryColor() -> UIColor {
        return config.colors.tertiary
    }
    
    public static func setTertiaryColor(color: UIColor) {
        config.colors.tertiary = color
    }
    
    public static func setRadiusMetrics(value: Int) {
        config.metrics.radius = value
    }
}
