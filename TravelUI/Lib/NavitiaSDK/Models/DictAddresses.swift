//
// DictAddresses.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class DictAddresses: JSONEncodable, Mappable {

    public var regions: [String]?
    public var message: String?
    public var context: Context?
    public var address: Address?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        regions <- map["regions"]
        message <- map["message"]
        context <- map["context"]
        address <- map["address"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["regions"] = self.regions?.encodeToJSON()
        nillableDictionary["message"] = self.message
        nillableDictionary["context"] = self.context?.encodeToJSON()
        nillableDictionary["address"] = self.address?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}