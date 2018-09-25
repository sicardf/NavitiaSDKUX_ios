//
// StopSchedulesApi.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

open class CoverageLonLatUriStopSchedulesRequestBuilder: NSObject {
    let currentApi: StopSchedulesApi

    /**
    * enum for parameter dataFreshness
    */
    public enum DataFreshness: String { 
        case baseSchedule = "base_schedule"
        case adaptedSchedule = "adapted_schedule"
        case realtime = "realtime"
    }
    var lat:Double? = nil
    var lon:Double? = nil
    var uri:String? = nil
    var filter:String? = nil
    var fromDatetime:Date? = nil
    var untilDatetime:Date? = nil
    var duration:Int32? = nil
    var depth:Int32? = nil
    var count:Int32? = nil
    var startPage:Int32? = nil
    var maxDateTimes:Int32? = nil
    var forbiddenId:[String]? = nil
    var forbiddenUris:[String]? = nil
    var calendar:String? = nil
    var distance:Int32? = nil
    var showCodes:Bool? = nil
    var dataFreshness: DataFreshness? = nil
    var itemsPerSchedule:Int32? = nil
    var disableGeojson:Bool? = nil
    var debugURL: String? = nil

    public init(currentApi: StopSchedulesApi) {
        self.currentApi = currentApi
    }

    open func withLat(_ lat: Double?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.lat = lat
        
        return self
    }
    open func withLon(_ lon: Double?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.lon = lon
        
        return self
    }
    open func withUri(_ uri: String?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.uri = uri
        
        return self
    }
    open func withFilter(_ filter: String?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.filter = filter
        
        return self
    }
    open func withFromDatetime(_ fromDatetime: Date?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.fromDatetime = fromDatetime
        
        return self
    }
    open func withUntilDatetime(_ untilDatetime: Date?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.untilDatetime = untilDatetime
        
        return self
    }
    open func withDuration(_ duration: Int32?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.duration = duration
        
        return self
    }
    open func withDepth(_ depth: Int32?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.depth = depth
        
        return self
    }
    open func withCount(_ count: Int32?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.count = count
        
        return self
    }
    open func withStartPage(_ startPage: Int32?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.startPage = startPage
        
        return self
    }
    open func withMaxDateTimes(_ maxDateTimes: Int32?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.maxDateTimes = maxDateTimes
        
        return self
    }
    open func withForbiddenId(_ forbiddenId: [String]?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.forbiddenId = forbiddenId
        
        return self
    }
    open func withForbiddenUris(_ forbiddenUris: [String]?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.forbiddenUris = forbiddenUris
        
        return self
    }
    open func withCalendar(_ calendar: String?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.calendar = calendar
        
        return self
    }
    open func withDistance(_ distance: Int32?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.distance = distance
        
        return self
    }
    open func withShowCodes(_ showCodes: Bool?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.showCodes = showCodes
        
        return self
    }
    open func withDataFreshness(_ dataFreshness: DataFreshness?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.dataFreshness = dataFreshness

        return self
    }
    open func withItemsPerSchedule(_ itemsPerSchedule: Int32?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.itemsPerSchedule = itemsPerSchedule
        
        return self
    }
    open func withDisableGeojson(_ disableGeojson: Bool?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.disableGeojson = disableGeojson
        
        return self
    }



    open func withDebugURL(_ debugURL: String?) -> CoverageLonLatUriStopSchedulesRequestBuilder {
        self.debugURL = debugURL
        return self
    }

    open func makeUrl() -> String {
        var path = "/coverage/{lon};{lat}/{uri}/stop_schedules"

        if let lat = lat {
            let latPreEscape: String = "\(lat)"
            let latPostEscape: String = latPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            path = path.replacingOccurrences(of: "{lat}", with: latPostEscape, options: .literal, range: nil)
        }

        if let lon = lon {
            let lonPreEscape: String = "\(lon)"
            let lonPostEscape: String = lonPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            path = path.replacingOccurrences(of: "{lon}", with: lonPostEscape, options: .literal, range: nil)
        }

        if let uri = uri {
            let uriPreEscape: String = "\(uri)"
            let uriPostEscape: String = uriPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            path = path.replacingOccurrences(of: "{uri}", with: uriPostEscape, options: .literal, range: nil)
        }

        let URLString = String(format: "%@%@", NavitiaSDKAPI.basePath, path)
        let url = NSURLComponents(string: URLString)

        let paramValues: [String: Any?] = [
            "filter": self.filter, 
            "from_datetime": self.fromDatetime?.encodeToJSON(), 
            "until_datetime": self.untilDatetime?.encodeToJSON(), 
            "duration": self.duration?.encodeToJSON(), 
            "depth": self.depth?.encodeToJSON(), 
            "count": self.count?.encodeToJSON(), 
            "start_page": self.startPage?.encodeToJSON(), 
            "max_date_times": self.maxDateTimes?.encodeToJSON(), 
            "forbidden_id[]": self.forbiddenId, 
            "forbidden_uris[]": self.forbiddenUris, 
            "calendar": self.calendar, 
            "distance": self.distance?.encodeToJSON(), 
            "show_codes": self.showCodes, 
            "data_freshness": self.dataFreshness?.rawValue, 
            "items_per_schedule": self.itemsPerSchedule?.encodeToJSON(), 
            "disable_geojson": self.disableGeojson
        ]
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: paramValues)
        url?.percentEncodedQuery = url?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        return (debugURL ?? url?.string ?? URLString)
    }

    open func get(completion: @escaping ((_ data: StopSchedules?,_ error: Error?) -> Void)) {
        if (self.lat == nil) {
            completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : lat"])))
        }
        if (self.lon == nil) {
            completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : lon"])))
        }
        if (self.uri == nil) {
            completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : uri"])))
        }

        request(self.makeUrl())
            .authenticate(user: currentApi.token, password: "")
            .validate()
            .responseObject{ (response: (DataResponse<StopSchedules>)) in
                switch response.result {
                case .success:
                    completion(response.result.value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    open func rawGet(completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
    if (self.lat == nil) {
        completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : lat"])))
    }
    if (self.lon == nil) {
        completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : lon"])))
    }
    if (self.uri == nil) {
        completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : uri"])))
    }

    request(self.makeUrl())
        .authenticate(user: currentApi.token, password: "")
        .validate()
        .responseString{ (response: (DataResponse<String>)) in
            switch response.result {
            case .success:
                completion(response.result.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

open class CoverageRegionUriStopSchedulesRequestBuilder: NSObject {
    let currentApi: StopSchedulesApi

    /**
    * enum for parameter dataFreshness
    */
    public enum DataFreshness: String { 
        case baseSchedule = "base_schedule"
        case adaptedSchedule = "adapted_schedule"
        case realtime = "realtime"
    }
    var region:String? = nil
    var uri:String? = nil
    var filter:String? = nil
    var fromDatetime:Date? = nil
    var untilDatetime:Date? = nil
    var duration:Int32? = nil
    var depth:Int32? = nil
    var count:Int32? = nil
    var startPage:Int32? = nil
    var maxDateTimes:Int32? = nil
    var forbiddenId:[String]? = nil
    var forbiddenUris:[String]? = nil
    var calendar:String? = nil
    var distance:Int32? = nil
    var showCodes:Bool? = nil
    var dataFreshness: DataFreshness? = nil
    var itemsPerSchedule:Int32? = nil
    var disableGeojson:Bool? = nil
    var debugURL: String? = nil

    public init(currentApi: StopSchedulesApi) {
        self.currentApi = currentApi
    }

    open func withRegion(_ region: String?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.region = region
        
        return self
    }
    open func withUri(_ uri: String?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.uri = uri
        
        return self
    }
    open func withFilter(_ filter: String?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.filter = filter
        
        return self
    }
    open func withFromDatetime(_ fromDatetime: Date?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.fromDatetime = fromDatetime
        
        return self
    }
    open func withUntilDatetime(_ untilDatetime: Date?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.untilDatetime = untilDatetime
        
        return self
    }
    open func withDuration(_ duration: Int32?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.duration = duration
        
        return self
    }
    open func withDepth(_ depth: Int32?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.depth = depth
        
        return self
    }
    open func withCount(_ count: Int32?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.count = count
        
        return self
    }
    open func withStartPage(_ startPage: Int32?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.startPage = startPage
        
        return self
    }
    open func withMaxDateTimes(_ maxDateTimes: Int32?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.maxDateTimes = maxDateTimes
        
        return self
    }
    open func withForbiddenId(_ forbiddenId: [String]?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.forbiddenId = forbiddenId
        
        return self
    }
    open func withForbiddenUris(_ forbiddenUris: [String]?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.forbiddenUris = forbiddenUris
        
        return self
    }
    open func withCalendar(_ calendar: String?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.calendar = calendar
        
        return self
    }
    open func withDistance(_ distance: Int32?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.distance = distance
        
        return self
    }
    open func withShowCodes(_ showCodes: Bool?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.showCodes = showCodes
        
        return self
    }
    open func withDataFreshness(_ dataFreshness: DataFreshness?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.dataFreshness = dataFreshness

        return self
    }
    open func withItemsPerSchedule(_ itemsPerSchedule: Int32?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.itemsPerSchedule = itemsPerSchedule
        
        return self
    }
    open func withDisableGeojson(_ disableGeojson: Bool?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.disableGeojson = disableGeojson
        
        return self
    }



    open func withDebugURL(_ debugURL: String?) -> CoverageRegionUriStopSchedulesRequestBuilder {
        self.debugURL = debugURL
        return self
    }

    open func makeUrl() -> String {
        var path = "/coverage/{region}/{uri}/stop_schedules"

        if let region = region {
            let regionPreEscape: String = "\(region)"
            let regionPostEscape: String = regionPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            path = path.replacingOccurrences(of: "{region}", with: regionPostEscape, options: .literal, range: nil)
        }

        if let uri = uri {
            let uriPreEscape: String = "\(uri)"
            let uriPostEscape: String = uriPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
            path = path.replacingOccurrences(of: "{uri}", with: uriPostEscape, options: .literal, range: nil)
        }

        let URLString = String(format: "%@%@", NavitiaSDKAPI.basePath, path)
        let url = NSURLComponents(string: URLString)

        let paramValues: [String: Any?] = [
            "filter": self.filter, 
            "from_datetime": self.fromDatetime?.encodeToJSON(), 
            "until_datetime": self.untilDatetime?.encodeToJSON(), 
            "duration": self.duration?.encodeToJSON(), 
            "depth": self.depth?.encodeToJSON(), 
            "count": self.count?.encodeToJSON(), 
            "start_page": self.startPage?.encodeToJSON(), 
            "max_date_times": self.maxDateTimes?.encodeToJSON(), 
            "forbidden_id[]": self.forbiddenId, 
            "forbidden_uris[]": self.forbiddenUris, 
            "calendar": self.calendar, 
            "distance": self.distance?.encodeToJSON(), 
            "show_codes": self.showCodes, 
            "data_freshness": self.dataFreshness?.rawValue, 
            "items_per_schedule": self.itemsPerSchedule?.encodeToJSON(), 
            "disable_geojson": self.disableGeojson
        ]
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: paramValues)
        url?.percentEncodedQuery = url?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        return (debugURL ?? url?.string ?? URLString)
    }

    open func get(completion: @escaping ((_ data: StopSchedules?,_ error: Error?) -> Void)) {
        if (self.region == nil) {
            completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : region"])))
        }
        if (self.uri == nil) {
            completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : uri"])))
        }

        request(self.makeUrl())
            .authenticate(user: currentApi.token, password: "")
            .validate()
            .responseObject{ (response: (DataResponse<StopSchedules>)) in
                switch response.result {
                case .success:
                    completion(response.result.value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    open func rawGet(completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {
    if (self.region == nil) {
        completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : region"])))
    }
    if (self.uri == nil) {
        completion(nil, ErrorResponse.Error(500, nil, NSError(domain: "localhost", code: 500, userInfo: ["reason": "Missing mandatory argument : uri"])))
    }

    request(self.makeUrl())
        .authenticate(user: currentApi.token, password: "")
        .validate()
        .responseString{ (response: (DataResponse<String>)) in
            switch response.result {
            case .success:
                completion(response.result.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

open class StopSchedulesRequestBuilder: NSObject {
    let currentApi: StopSchedulesApi

    /**
    * enum for parameter dataFreshness
    */
    public enum DataFreshness: String { 
        case baseSchedule = "base_schedule"
        case adaptedSchedule = "adapted_schedule"
        case realtime = "realtime"
    }
    var filter:String? = nil
    var fromDatetime:Date? = nil
    var untilDatetime:Date? = nil
    var duration:Int32? = nil
    var depth:Int32? = nil
    var count:Int32? = nil
    var startPage:Int32? = nil
    var maxDateTimes:Int32? = nil
    var forbiddenId:[String]? = nil
    var forbiddenUris:[String]? = nil
    var calendar:String? = nil
    var distance:Int32? = nil
    var showCodes:Bool? = nil
    var dataFreshness: DataFreshness? = nil
    var itemsPerSchedule:Int32? = nil
    var disableGeojson:Bool? = nil
    var debugURL: String? = nil

    public init(currentApi: StopSchedulesApi) {
        self.currentApi = currentApi
    }

    open func withFilter(_ filter: String?) -> StopSchedulesRequestBuilder {
        self.filter = filter
        
        return self
    }
    open func withFromDatetime(_ fromDatetime: Date?) -> StopSchedulesRequestBuilder {
        self.fromDatetime = fromDatetime
        
        return self
    }
    open func withUntilDatetime(_ untilDatetime: Date?) -> StopSchedulesRequestBuilder {
        self.untilDatetime = untilDatetime
        
        return self
    }
    open func withDuration(_ duration: Int32?) -> StopSchedulesRequestBuilder {
        self.duration = duration
        
        return self
    }
    open func withDepth(_ depth: Int32?) -> StopSchedulesRequestBuilder {
        self.depth = depth
        
        return self
    }
    open func withCount(_ count: Int32?) -> StopSchedulesRequestBuilder {
        self.count = count
        
        return self
    }
    open func withStartPage(_ startPage: Int32?) -> StopSchedulesRequestBuilder {
        self.startPage = startPage
        
        return self
    }
    open func withMaxDateTimes(_ maxDateTimes: Int32?) -> StopSchedulesRequestBuilder {
        self.maxDateTimes = maxDateTimes
        
        return self
    }
    open func withForbiddenId(_ forbiddenId: [String]?) -> StopSchedulesRequestBuilder {
        self.forbiddenId = forbiddenId
        
        return self
    }
    open func withForbiddenUris(_ forbiddenUris: [String]?) -> StopSchedulesRequestBuilder {
        self.forbiddenUris = forbiddenUris
        
        return self
    }
    open func withCalendar(_ calendar: String?) -> StopSchedulesRequestBuilder {
        self.calendar = calendar
        
        return self
    }
    open func withDistance(_ distance: Int32?) -> StopSchedulesRequestBuilder {
        self.distance = distance
        
        return self
    }
    open func withShowCodes(_ showCodes: Bool?) -> StopSchedulesRequestBuilder {
        self.showCodes = showCodes
        
        return self
    }
    open func withDataFreshness(_ dataFreshness: DataFreshness?) -> StopSchedulesRequestBuilder {
        self.dataFreshness = dataFreshness

        return self
    }
    open func withItemsPerSchedule(_ itemsPerSchedule: Int32?) -> StopSchedulesRequestBuilder {
        self.itemsPerSchedule = itemsPerSchedule
        
        return self
    }
    open func withDisableGeojson(_ disableGeojson: Bool?) -> StopSchedulesRequestBuilder {
        self.disableGeojson = disableGeojson
        
        return self
    }



    open func withDebugURL(_ debugURL: String?) -> StopSchedulesRequestBuilder {
        self.debugURL = debugURL
        return self
    }

    open func makeUrl() -> String {
        let path = "/stop_schedules"

        let URLString = String(format: "%@%@", NavitiaSDKAPI.basePath, path)
        let url = NSURLComponents(string: URLString)

        let paramValues: [String: Any?] = [
            "filter": self.filter, 
            "from_datetime": self.fromDatetime?.encodeToJSON(), 
            "until_datetime": self.untilDatetime?.encodeToJSON(), 
            "duration": self.duration?.encodeToJSON(), 
            "depth": self.depth?.encodeToJSON(), 
            "count": self.count?.encodeToJSON(), 
            "start_page": self.startPage?.encodeToJSON(), 
            "max_date_times": self.maxDateTimes?.encodeToJSON(), 
            "forbidden_id[]": self.forbiddenId, 
            "forbidden_uris[]": self.forbiddenUris, 
            "calendar": self.calendar, 
            "distance": self.distance?.encodeToJSON(), 
            "show_codes": self.showCodes, 
            "data_freshness": self.dataFreshness?.rawValue, 
            "items_per_schedule": self.itemsPerSchedule?.encodeToJSON(), 
            "disable_geojson": self.disableGeojson
        ]
        url?.queryItems = APIHelper.mapValuesToQueryItems(values: paramValues)
        url?.percentEncodedQuery = url?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        return (debugURL ?? url?.string ?? URLString)
    }

    open func get(completion: @escaping ((_ data: StopSchedules?,_ error: Error?) -> Void)) {

        request(self.makeUrl())
            .authenticate(user: currentApi.token, password: "")
            .validate()
            .responseObject{ (response: (DataResponse<StopSchedules>)) in
                switch response.result {
                case .success:
                    completion(response.result.value, nil)
                case .failure(let error):
                    completion(nil, error)
                }
            }
    }

    open func rawGet(completion: @escaping ((_ data: String?,_ error: Error?) -> Void)) {

    request(self.makeUrl())
        .authenticate(user: currentApi.token, password: "")
        .validate()
        .responseString{ (response: (DataResponse<String>)) in
            switch response.result {
            case .success:
                completion(response.result.value, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}



open class StopSchedulesApi: APIBase {
    let token: String

    public init(token: String) {
        self.token = token
    }

    public func newCoverageLonLatUriStopSchedulesRequestBuilder() -> CoverageLonLatUriStopSchedulesRequestBuilder {
        return CoverageLonLatUriStopSchedulesRequestBuilder(currentApi: self)
    }
    public func newCoverageRegionUriStopSchedulesRequestBuilder() -> CoverageRegionUriStopSchedulesRequestBuilder {
        return CoverageRegionUriStopSchedulesRequestBuilder(currentApi: self)
    }
    public func newStopSchedulesRequestBuilder() -> StopSchedulesRequestBuilder {
        return StopSchedulesRequestBuilder(currentApi: self)
    }
}
