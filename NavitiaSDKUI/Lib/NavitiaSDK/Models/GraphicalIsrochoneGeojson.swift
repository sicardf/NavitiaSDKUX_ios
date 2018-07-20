//
// GraphicalIsrochoneGeojson.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class GraphicalIsrochoneGeojson: JSONEncodable, Mappable {

    public var coordinates: [[[[Float]]]]?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        coordinates <- map["coordinates"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["coordinates"] = self.coordinates?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
