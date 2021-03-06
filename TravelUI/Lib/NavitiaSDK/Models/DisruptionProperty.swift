//
// DisruptionProperty.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class DisruptionProperty: JSONEncodable, Mappable {

    public var type: String?
    public var key: String?
    public var value: String?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        type <- map["type"]
        key <- map["key"]
        value <- map["value"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["type"] = self.type
        nillableDictionary["key"] = self.key
        nillableDictionary["value"] = self.value

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
