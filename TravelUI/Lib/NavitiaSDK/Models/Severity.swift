//
// Severity.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class Severity: JSONEncodable, Mappable {

    public enum Effect: String { 
        case noService = "NO_SERVICE"
        case reducedService = "REDUCED_SERVICE"
        case significantDelays = "SIGNIFICANT_DELAYS"
        case detour = "DETOUR"
        case additionalService = "ADDITIONAL_SERVICE"
        case modifiedService = "MODIFIED_SERVICE"
        case otherEffect = "OTHER_EFFECT"
        case unknownEffect = "UNKNOWN_EFFECT"
        case stopMoved = "STOP_MOVED"
    }
    public var color: String?
    public var priority: Int32?
    public var name: String?
    public var effect: Effect?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        color <- map["color"]
        priority <- map["priority"]
        name <- map["name"]
        effect <- map["effect"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["color"] = self.color
        nillableDictionary["priority"] = self.priority?.encodeToJSON()
        nillableDictionary["name"] = self.name
        nillableDictionary["effect"] = self.effect?.rawValue

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
