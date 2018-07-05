//
// Stands.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class Stands: JSONEncodable, Mappable {

    public var availablePlaces: Int32?
    public var availableBikes: Int32?
    public var totalStands: Int32?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        availablePlaces <- map["available_places"]
        availableBikes <- map["available_bikes"]
        totalStands <- map["total_stands"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["available_places"] = self.availablePlaces?.encodeToJSON()
        nillableDictionary["available_bikes"] = self.availableBikes?.encodeToJSON()
        nillableDictionary["total_stands"] = self.totalStands?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
