//
// RidesharingInformation.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class RidesharingInformation: JSONEncodable, Mappable {

    public var _operator: String?
    public var driver: IndividualInformation?
    public var network: String?
    public var seats: SeatsDescription?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        _operator <- map["operator"]
        driver <- map["driver"]
        network <- map["network"]
        seats <- map["seats"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["operator"] = self._operator
        nillableDictionary["driver"] = self.driver?.encodeToJSON()
        nillableDictionary["network"] = self.network
        nillableDictionary["seats"] = self.seats?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
