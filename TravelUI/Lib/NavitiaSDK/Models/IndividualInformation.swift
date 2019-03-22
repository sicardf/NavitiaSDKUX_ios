//
// IndividualInformation.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class IndividualInformation: JSONEncodable, Mappable {

    public enum Gender: String { 
        case female = "female"
        case male = "male"
    }
    public var alias: String?
    public var image: String?
    public var gender: Gender?
    public var rating: IndividualRating?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        alias <- map["alias"]
        image <- map["image"]
        gender <- map["gender"]
        rating <- map["rating"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["alias"] = self.alias
        nillableDictionary["image"] = self.image
        nillableDictionary["gender"] = self.gender?.rawValue
        nillableDictionary["rating"] = self.rating?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}