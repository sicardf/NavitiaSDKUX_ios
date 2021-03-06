//
// HeatMap.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class HeatMap: JSONEncodable, Mappable {

    public var to: Place?
    public var requestedDateTime: String?
    public var from: Place?
    public var heatMatrix: HeatMatrixSchema?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        to <- map["to"]
        requestedDateTime <- map["requested_date_time"]
        from <- map["from"]
        heatMatrix <- map["heat_matrix"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["to"] = self.to?.encodeToJSON()
        nillableDictionary["requested_date_time"] = self.requestedDateTime
        nillableDictionary["from"] = self.from?.encodeToJSON()
        nillableDictionary["heat_matrix"] = self.heatMatrix?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
