//
// Distances.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class Distances: JSONEncodable, Mappable {

    /** Total distance by car of the journey (meters) */
    public var car: Int32?
    /** Total walking distance of the journey (meters) */
    public var walking: Int32?
    /** Total distance by bike of the journey (meters) */
    public var bike: Int32?
    /** Total distance by ridesharing of the journey (meters) */
    public var ridesharing: Int32?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        car <- map["car"]
        walking <- map["walking"]
        bike <- map["bike"]
        ridesharing <- map["ridesharing"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["car"] = self.car?.encodeToJSON()
        nillableDictionary["walking"] = self.walking?.encodeToJSON()
        nillableDictionary["bike"] = self.bike?.encodeToJSON()
        nillableDictionary["ridesharing"] = self.ridesharing?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
