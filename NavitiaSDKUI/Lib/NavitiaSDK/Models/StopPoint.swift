//
// StopPoint.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class StopPoint: JSONEncodable, Mappable {

    public enum Equipments: String { 
        case wheelchairAccessibility = "has_wheelchair_accessibility"
        case bikeAccepted = "has_bike_accepted"
        case airConditioned = "has_air_conditioned"
        case visualAnnouncement = "has_visual_announcement"
        case audibleAnnouncement = "has_audible_announcement"
        case appropriateEscort = "has_appropriate_escort"
        case appropriateSignage = "has_appropriate_signage"
        case schoolVehicle = "has_school_vehicle"
        case wheelchairBoarding = "has_wheelchair_boarding"
        case sheltered = "has_sheltered"
        case elevator = "has_elevator"
        case escalator = "has_escalator"
        case bikeDepot = "has_bike_depot"
    }
    public var comment: String?
    public var codes: [Code]?
    /** Name of the object */
    public var name: String?
    public var links: [LinkSchema]?
    public var physicalModes: [PhysicalMode]?
    public var coord: Coord?
    public var label: String?
    public var equipments: [Equipments]?
    public var commercialModes: [CommercialMode]?
    public var comments: [Comment]?
    public var administrativeRegions: [Admin]?
    public var address: Address?
    /** Identifier of the object */
    public var id: String?
    public var stopArea: StopArea?

    public init() {}
    required public init?(map: Map) {

    }


    public func mapping(map: Map) {
        comment <- map["comment"]
        codes <- map["codes"]
        name <- map["name"]
        links <- map["links"]
        physicalModes <- map["physical_modes"]
        coord <- map["coord"]
        label <- map["label"]
        equipments <- map["equipments"]
        commercialModes <- map["commercial_modes"]
        comments <- map["comments"]
        administrativeRegions <- map["administrative_regions"]
        address <- map["address"]
        id <- map["id"]
        stopArea <- map["stop_area"]
    }

    // MARK: JSONEncodable
    open func encodeToJSON() -> Any {
        var nillableDictionary = [String:Any?]()
        nillableDictionary["comment"] = self.comment
        nillableDictionary["codes"] = self.codes?.encodeToJSON()
        nillableDictionary["name"] = self.name
        nillableDictionary["links"] = self.links?.encodeToJSON()
        nillableDictionary["physical_modes"] = self.physicalModes?.encodeToJSON()
        nillableDictionary["coord"] = self.coord?.encodeToJSON()
        nillableDictionary["label"] = self.label
        nillableDictionary["equipments"] = self.equipments?.map({$0.rawValue}).encodeToJSON()
        nillableDictionary["commercial_modes"] = self.commercialModes?.encodeToJSON()
        nillableDictionary["comments"] = self.comments?.encodeToJSON()
        nillableDictionary["administrative_regions"] = self.administrativeRegions?.encodeToJSON()
        nillableDictionary["address"] = self.address?.encodeToJSON()
        nillableDictionary["id"] = self.id
        nillableDictionary["stop_area"] = self.stopArea?.encodeToJSON()

        let dictionary: [String:Any] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
