//
// Message.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class Message: JSONEncodable, Mappable {

    public var text: String?
    public var channel: Channel?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        text <- map["text"]
        channel <- map["channel"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["text"] = self.text
        nillableDictionary["channel"] = self.channel?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
