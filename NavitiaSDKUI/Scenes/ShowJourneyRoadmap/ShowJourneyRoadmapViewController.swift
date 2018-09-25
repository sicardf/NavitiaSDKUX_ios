//
//  ShowJourneyRoadmapViewController.swift
//  NavitiaSDKUI
//
//  Copyright © 2018 kisio. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol ShowJourneyRoadmapDisplayLogic: class {
    
    func displayRoadmap(viewModel: ShowJourneyRoadmap.GetRoadmap.ViewModel)
    func displayMap(viewModel: ShowJourneyRoadmap.GetMap.ViewModel)
}

internal class ShowJourneyRoadmapViewController: UIViewController, ShowJourneyRoadmapDisplayLogic {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var scrollView: StackScrollView!
    
    internal var router: (NSObjectProtocol & ShowJourneyRoadmapRoutingLogic & ShowJourneyRoadmapDataPassing)?
    private var interactor: ShowJourneyRoadmapBusinessLogic?
    private var viewModel: ShowJourneyRoadmap.GetRoadmap.ViewModel?
    private var mapViewModel: ShowJourneyRoadmap.GetMap.ViewModel?
    
    // Maps
    var intermediatePointsCircles = [SectionCircle]()
    var journeyPolylineCoordinates = [CLLocationCoordinate2D]()
    var sectionsPolylines = [SectionPolyline]()
    let locationManager = CLLocationManager()

    // Bss Real Time
    var animationTimer: Timer?
    var standBikeTime: Timer?
    var bssTest = [(poi: ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean.Poi,
                    notify: ((ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean.Poi) -> ()))]()
    
    // /!\ Remove
    var display = false
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initArchitecture()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "roadmap".localized(withComment: "Roadmap", bundle: NavitiaSDKUI.shared.bundle)

        initScrollView()
        initLocation()
        
        //getMap()
        getRoadmap()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        startUpdatingUserLocation()

        refreshFetchBss(run: true)
        startAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        stopUpdatingUserLocation()
        
        refreshFetchBss(run: false)
        stopAnimation()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !display {
            display = true
            zoomOverPolyline(targetPolyline: MKPolyline(coordinates: journeyPolylineCoordinates, count: journeyPolylineCoordinates.count))
        }
        scrollView.reloadStack()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private func initArchitecture() {
        let viewController = self
        let interactor = ShowJourneyRoadmapInteractor()
        let presenter = ShowJourneyRoadmapPresenter()
        let router = ShowJourneyRoadmapRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func initScrollView() {
        if #available(iOS 11.0, *) {
            scrollView?.contentInsetAdjustmentBehavior = .always
        }
        scrollView?.bounces = false
    }
    
    private func initLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func initMapView() {
        setupMapView()
    }
    
    func displayRoadmap(viewModel: ShowJourneyRoadmap.GetRoadmap.ViewModel) {
        self.viewModel = viewModel
        
        scrollView.reloadStack()
        guard let journey = self.viewModel?.journey, let sections = self.viewModel?.sections else {
            return
        }
        
        getHeader(journey)
        getDepartureArrival(data: viewModel.departure)
        getStep(sections: sections)
        getDepartureArrival(data: viewModel.arrival)
        getEmission(emission: viewModel.emission)
        getMap()
    }
    
    func displayMap(viewModel: ShowJourneyRoadmap.GetMap.ViewModel) {
        self.mapViewModel = viewModel
        
        initMapView()
    }
    
    // MARK: - Get roadmap
    
    private func getRoadmap() {
        let request = ShowJourneyRoadmap.GetRoadmap.Request()
        
        self.interactor?.getRoadmap(request: request)
    }
    
    private func getMap() {
        let request = ShowJourneyRoadmap.GetMap.Request()
        
        self.interactor?.getMap(request: request)
    }
    
    @objc private func fetchBss() {
        for (poi, notify) in bssTest {
            let request = ShowJourneyRoadmap.FetchBss.Request(lat: poi.lat, lon: poi.lont, distance: 10, id: poi.addressId, notify: notify)
            
            self.interactor?.fetchBss(request: request)
        }
    }
    
    private func refreshFetchBss(run: Bool = true) {
        standBikeTime?.invalidate()
        
        if run {
            standBikeTime = Timer.scheduledTimer(timeInterval: Configuration.bssTimeInterval, target: self, selector: #selector(fetchBss), userInfo: nil, repeats: true)
            standBikeTime?.fire()
        }
    }
    
    // MARK: Tools
    
    private func getHeader(_ journey: Journey) {
        let journeySolutionView = getJourneySolutionView(journey: journey)
        
        scrollView.addSubview(journeySolutionView, margin: UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0))
        if let _ = viewModel?.ridesharing {
            guard let duration = journey.duration, let sections = journey.sections else {
                return
            }
            
            let ridesharingView = getRidesharingView()
            
            journeySolutionView.setRidesharingData(duration: duration, sections: sections)
            scrollView.addSubview(ridesharingView, margin: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        }
    }
    
    private func getJourneySolutionView(journey: Journey) -> JourneySolutionView {
        let journeySolutionView = JourneySolutionView(frame: CGRect(x: 0, y: 0, width: 0, height: 60))
        
        journeySolutionView.disruptions = viewModel?.disruptions
        journeySolutionView.setData(journey)
        
        return journeySolutionView
    }
    
    private func getRidesharingView() -> RidesharingView {
        let ridesharingView = RidesharingView(frame: CGRect(x: 0, y: 0, width: 0, height: 255))

        ridesharingView.parentViewController = self
        
        return ridesharingView
    }
    
    private func getDepartureArrival(data: ShowJourneyRoadmap.GetRoadmap.ViewModel.DepartureArrival) {
        let departureArrivalStepView = DepartureArrivalStepView(frame: CGRect(x: 0, y: 0, width: 0, height: 70))
        
        departureArrivalStepView.information = data.information
        departureArrivalStepView.time = data.time
        departureArrivalStepView.type = data.mode
        departureArrivalStepView.calorie = data.calorie
        
        scrollView.addSubview(departureArrivalStepView, margin: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
    }
    
    private func getStep(sections: [ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean]) {
        for (_, section) in sections.enumerated() {
            if let sectionStep = getSectionStep(section: section) {
                scrollView.addSubview(sectionStep, margin: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
            }
        }
    }
    
    private func getPublicTransportStep(section: ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean) -> UIView {
        let publicTransportView = PublicTransportView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        
        publicTransportView.modeString = section.icon
        publicTransportView.take = section.displayInformations.commercialMode
        publicTransportView.transportColor = section.displayInformations.color
        publicTransportView.transportName = section.displayInformations.code
        publicTransportView.origin = section.from
        publicTransportView.startTime = section.startTime
        publicTransportView.directionTransit = section.displayInformations.directionTransit
        publicTransportView.destination = section.to
        publicTransportView.endTime = section.endTime
        publicTransportView.stations = section.stopDate
        publicTransportView.waitingTime = section.waiting
        publicTransportView.setDisruptions(section.disruptions)
        for note in section.notes {
            publicTransportView.setOnDemandTransport(text: note.content)
        }
        
        return publicTransportView
    }
    
    private func getBssStep(section: ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean) -> UIView {
        let bssStepView = BssStepView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        
        bssStepView.modeString = section.icon
        bssStepView.type = Section.ModelType.init(rawValue: section.type.rawValue)
        
        if let poi = section.poi {
            bssStepView.takeName = poi.network
            bssStepView.origin = poi.name
            bssStepView.address = poi.addressName
            bssStepView.realTimeEnabled = section.bssRealTime
            bssStepView.updateStandsClean(poi: poi, type: section.type)
            
            refreshFetchBss(run: section.bssRealTime)
            
            if let _ = poi.stands {
                bssTest.append((poi: poi, notify: { (poi) in
                    bssStepView.updateStandsClean(poi: poi, type: section.type)
                }))
            }
        }
        
        return bssStepView
    }
    
    private func getRidesharingStep(section: ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean) -> UIView {
        let view = RidesharingStepView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        view.origin = section.from
        view.destination = section.to
        view.time = section.duration
        
        return view
    }
    
    func getGenericStep(section: ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean) -> UIView {
        let view = GenericStepView(frame: CGRect(x: 0, y: 0, width: 0, height: 50))
        view.modeString = section.icon
        view.time = section.duration
        view.direction = section.to
        view.paths = section.path
        
        return view
    }
    
    private func getEmission(emission: ShowJourneyRoadmap.GetRoadmap.ViewModel.Emission) {
        let emissionView = EmissionView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: 60))
        emissionView.journeyCarbon = emission.journey
        emissionView.carCarbon = emission.car
        
        scrollView.addSubview(emissionView, margin: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
    
    private func getSectionStep(section: ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean) -> UIView? {
        switch section.type {
        case .publicTransport:
            return getPublicTransportStep(section: section)
        case .onDemandTransport:
            return getPublicTransportStep(section: section)
        case .streetNetwork:
            return getStreetNetworkStep(section: section)
        case .bssRent:
            return getBssStep(section: section)
        case .bssPutBack:
            return getBssStep(section: section)
        case .crowFly:
            return getGenericStep(section: section)
        default:
            return nil
        }
    }
    
    private func getStreetNetworkStep(section: ShowJourneyRoadmap.GetRoadmap.ViewModel.SectionClean) -> UIView? {
        guard let mode = section.mode else {
            return nil
        }
        
        switch mode {
        case .walking:
            return getGenericStep(section: section)
        case .bike:
            return getGenericStep(section: section)
        case .car:
            return getGenericStep(section: section)
        case .ridesharing:
            updateRidesharingView(section.section)
            return getRidesharingStep(section: section)
        default:
            return nil
        }
    }
    
    private func updateRidesharingView(_ section: Section) {
        guard let ridesharing = viewModel?.ridesharing, let ridesharingView = scrollView.selectSubviews(type: RidesharingView()).first else {
            return
        }
        
        ridesharingView.price = ridesharing.price
        ridesharingView.title = ridesharing.network
        ridesharingView.startDate = ridesharing.departure
        ridesharingView.login = ridesharing.driverNickname
        ridesharingView.gender = ridesharing.driverGender
        ridesharingView.addressFrom = ridesharing.departureAddress
        ridesharingView.addressTo = ridesharing.arrivalAddress
        ridesharingView.seatCount(ridesharing.seatsCount)
        ridesharingView.setPicture(url: ridesharing.driverPictureURL)
        ridesharingView.setNotation(ridesharing.ratingCount)
        ridesharingView.setFullStar(ridesharing.rating)
    }
    
    // MARKS: Update BSS

    @objc private func startAnimation() {
        animationTimer?.invalidate()
        animationTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(startAnimation), userInfo: nil, repeats: true)
        
        let bssStepSubviews = scrollView.selectSubviews(type: BssStepView())
        for bssStepView in bssStepSubviews {
            bssStepView.animateRealTime()
        }
    }
    
    private func stopAnimation() {
        animationTimer?.invalidate()
        
        let bssStepSubviews = scrollView.selectSubviews(type: BssStepView())
        for bssStepView in bssStepSubviews {
            bssStepView.stopRealTimeAnimation()
        }
    }
    
    // MARKS: Ridesharing Open Link
    
    public func openDeepLink() {
        if let ridesharingDeepLink = viewModel?.ridesharing?.deepLink {
            if let urlRidesharingDeepLink = URL(string: ridesharingDeepLink) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(urlRidesharingDeepLink, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(urlRidesharingDeepLink)
                }
            }
        }
    }
    
}

// MARKS: Maps

extension ShowJourneyRoadmapViewController {
    
    private func setupMapView() {
        self.mapView.showsUserLocation = true
        
        drawSections(journey: mapViewModel?.journey)
        
        if mapViewModel?.journey.sections?.first?.type == Section.ModelType.crowFly {
            if (mapViewModel?.journey.sections?.count)! - 1 >= 1 {
                if mapViewModel?.journey.sections![1].type == .ridesharing, let departureCrowflyCoords = getCrowFlyCoordinates(targetPlace: mapViewModel?.journey.sections?.first?.from), let latitude = departureCrowflyCoords.lat, let lat = Double(latitude), let longitude = departureCrowflyCoords.lon, let lon = Double(longitude) {
                   _drawPinAnnotation(coordinates: [lon, lat], annotationType: .PlaceAnnotation, placeType: .Departure)
                } else {
                    _drawPinAnnotation(coordinates: mapViewModel?.journey.sections?[1].geojson?.coordinates?.first, annotationType: .PlaceAnnotation, placeType: .Departure)
                }
            }
        } else {
            _drawPinAnnotation(coordinates: mapViewModel?.journey.sections?.first?.geojson?.coordinates?.first, annotationType: .PlaceAnnotation, placeType: .Departure)
        }
        
        if mapViewModel?.journey.sections?.last?.type == Section.ModelType.crowFly {
            if ((mapViewModel?.journey.sections?.count)! - 1 > 1) {
                if mapViewModel?.journey.sections![(mapViewModel?.journey.sections?.count)! - 2].type == .ridesharing, let arrivalCrowflyCoords = getCrowFlyCoordinates(targetPlace: mapViewModel?.journey.sections?.last?.to), let latitude = arrivalCrowflyCoords.lat, let lat = Double(latitude), let longitude = arrivalCrowflyCoords.lon, let lon = Double(longitude) {
                    _drawPinAnnotation(coordinates: [lon, lat], annotationType: .PlaceAnnotation, placeType: .Arrival)
                } else {
                    _drawPinAnnotation(coordinates: mapViewModel?.journey.sections?[(mapViewModel?.journey.sections?.count)! - 2].geojson?.coordinates?.last, annotationType: .PlaceAnnotation, placeType: .Arrival)
                }
            }
        } else {
            _drawPinAnnotation(coordinates: mapViewModel?.journey.sections?.last?.geojson?.coordinates?.last, annotationType: .PlaceAnnotation, placeType: .Arrival)
        }
        
        _redrawIntermediatePointCircles(mapView: mapView, cameraAltitude: mapView.camera.altitude)
        zoomOverPolyline(targetPolyline: MKPolyline(coordinates: journeyPolylineCoordinates, count: journeyPolylineCoordinates.count))
    }
    
    private func drawSections(journey: Journey?) {
        guard let sections = journey?.sections else {
            return
        }
        
        for (index , section) in sections.enumerated() {
            if !_drawRidesharingSection(section: section) {
                var sectionPolylineCoordinates = [CLLocationCoordinate2D]()
                if section.type == .crowFly && ((index - 1 >= 0 && sections[index-1].type == .ridesharing) || (index + 1 < sections.count - 1 && sections[index+1].type == .ridesharing)) {
                    if let departureCrowflyCoords = getCrowFlyCoordinates(targetPlace: section.from), let latitude = departureCrowflyCoords.lat, let lat = Double(latitude), let longitude = departureCrowflyCoords.lon, let lon = Double(longitude) {
                        sectionPolylineCoordinates.append(CLLocationCoordinate2DMake(lat, lon))
                    }
                    
                    if let arrivalCrowflyCoords = getCrowFlyCoordinates(targetPlace: section.to), let latitude = arrivalCrowflyCoords.lat, let lat = Double(latitude), let longitude = arrivalCrowflyCoords.lon, let lon = Double(longitude) {
                        sectionPolylineCoordinates.append(CLLocationCoordinate2DMake(lat, lon))
                    }
                } else if let coordinates = section.geojson?.coordinates {
                    for (_, coordinate) in coordinates.enumerated() {
                        if coordinate.count > 1 {
                            sectionPolylineCoordinates.append(CLLocationCoordinate2DMake(Double(coordinate[1]), Double(coordinate[0])))
                        }
                    }
                }
                
                _addSectionCircle(section: section)
                _addSectionPolyline(sectionPolylineCoordinates: sectionPolylineCoordinates, section: section)
            }
        }
    }
    
    private func _drawRidesharingSection(section: Section) -> Bool {
        if section.ridesharingJourneys != nil, let ridesharingJourney = viewModel?.ridesharingJourneys {
            
            drawSections(journey: ridesharingJourney)
            return true
        }
        
        
        if section.type == .ridesharing {
            _drawPinAnnotation(coordinates: section.geojson?.coordinates?.first, annotationType: .RidesharingAnnotation, placeType: .Other)
            _drawPinAnnotation(coordinates: section.geojson?.coordinates?.last, annotationType: .RidesharingAnnotation, placeType: .Other)
        }
        
        return false
    }
    
    private func _drawPinAnnotation(coordinates: [Double]?, annotationType: CustomAnnotation.AnnotationType, placeType: CustomAnnotation.PlaceType) {
        guard let coordinates = coordinates else {
            return
        }
        
        if coordinates.count > 1 {
            mapView.addAnnotation(CustomAnnotation(coordinate: CLLocationCoordinate2DMake(coordinates[1], coordinates[0]),
                                                   annotationType: annotationType,
                                                   placeType: placeType))
            _getCircle(coordinates: coordinates)
        }
    }
    
    private func _addSectionPolyline(sectionPolylineCoordinates: [CLLocationCoordinate2D], section: Section) {
        var sectionPolyline = SectionPolyline(coordinates: sectionPolylineCoordinates, count: sectionPolylineCoordinates.count)

        switch section.type {
        case .streetNetwork?:
            _streetNetworkPolyline(mode: section.mode, sectionPolyline: &sectionPolyline)
        case .crowFly?:
            _crowFlyPolyline(mode: section.mode, sectionPolyline: &sectionPolyline)
        case .publicTransport?:
            sectionPolyline.sectionStrokeColor = section.displayInformations?.color?.toUIColor()
            sectionPolyline.sectionLineWidth = 5
        case .transfer?:
            sectionPolyline.sectionStrokeColor = Configuration.Color.gray
            sectionPolyline.sectionLineWidth = 4
        case .ridesharing?:
            sectionPolyline.sectionStrokeColor = UIColor.black
            sectionPolyline.sectionLineWidth = 4
        default:
            sectionPolyline.sectionStrokeColor = UIColor.black
            sectionPolyline.sectionLineWidth = 4
        }
        
        sectionsPolylines.append(sectionPolyline)
        journeyPolylineCoordinates.append(contentsOf: sectionPolylineCoordinates)
        mapView.add(sectionPolyline)
    }
    
    private func _streetNetworkPolyline(mode: Section.Mode?, sectionPolyline: inout SectionPolyline) {
        sectionPolyline.sectionStrokeColor = Configuration.Color.gray
        sectionPolyline.sectionLineWidth = 4
        
        switch mode {
        case .walking?:
            sectionPolyline.sectionLineDashPattern = [0.01, NSNumber(value: Float(2 * sectionPolyline.sectionLineWidth))]
            sectionPolyline.sectionLineCap = CGLineCap.round
        default:
            break
        }
    }
    
    private func _crowFlyPolyline(mode: Section.Mode?, sectionPolyline: inout SectionPolyline) {
        sectionPolyline.sectionStrokeColor = Configuration.Color.gray
        sectionPolyline.sectionLineWidth = 4
        
        switch mode {
        case .walking?:
            sectionPolyline.sectionLineDashPattern = [0.01, NSNumber(value: Float(2 * sectionPolyline.sectionLineWidth))]
            sectionPolyline.sectionLineCap = CGLineCap.round
        default:
            break
        }
    }
    
    private func getCrowFlyCoordinates(targetPlace: Place?) -> Coord? {
        guard let targetPlace = targetPlace else {
            return nil;
        }
        
        switch targetPlace.embeddedType {
        case .stopPoint?:
            return targetPlace.stopPoint?.coord
        case .stopArea?:
            return targetPlace.stopArea?.coord
        case .poi?:
            return targetPlace.poi?.coord
        case .address?:
            return targetPlace.address?.coord
        case .administrativeRegion?:
            return targetPlace.administrativeRegion?.coord
        default:
            return nil
        }
    }
    
    private func _getCircle(coordinates: [Double]?, backgroundColor: UIColor? = Configuration.Color.black) {
        guard let coordinates = coordinates else {
            return
        }
        
        var backgroundColor = backgroundColor
        if backgroundColor == nil {
            backgroundColor = Configuration.Color.black
        }
        
        if coordinates.count > 1 {
            let sectionCircle = SectionCircle(center: CLLocationCoordinate2DMake(coordinates[1], coordinates[0]),
                                              radius: _getCircleRadiusDependingOnCurrentCameraAltitude(cameraAltitude: mapView.camera.altitude))
            sectionCircle.sectionBackgroundColor = backgroundColor
            intermediatePointsCircles.append(sectionCircle)
        }
    }
    
    private func _addSectionCircle(section: Section) {
        if let coordinates = section.geojson?.coordinates {
            var backgroundColor = section.displayInformations?.color?.toUIColor()
            if section.type == .ridesharing {
                backgroundColor = Configuration.Color.black
            }
            
            _getCircle(coordinates: coordinates.first, backgroundColor: backgroundColor)
            _getCircle(coordinates: coordinates.last, backgroundColor: backgroundColor)
        }
    }
    
    private func _getCircleRadiusDependingOnCurrentCameraAltitude(cameraAltitude: CLLocationDistance) -> CLLocationDistance {
        let altitudeReferenceValue = 10000.0
        let circleMaxmimumRadius = 100.0
        return cameraAltitude/altitudeReferenceValue * circleMaxmimumRadius
    }
    
    private func _redrawIntermediatePointCircles(mapView: MKMapView, cameraAltitude: CLLocationDistance) {
        mapView.removeOverlays(intermediatePointsCircles)
        
        var updatedIntermediatePointsCircles = [SectionCircle]()
        for (_, drawnCircle) in intermediatePointsCircles.enumerated() {
            let updatedCircleView = SectionCircle(center: drawnCircle.coordinate,
                                                  radius: _getCircleRadiusDependingOnCurrentCameraAltitude(cameraAltitude: cameraAltitude))
            updatedCircleView.sectionBackgroundColor = drawnCircle.sectionBackgroundColor
            updatedIntermediatePointsCircles.append(updatedCircleView)
        }
        intermediatePointsCircles = updatedIntermediatePointsCircles
        
        mapView.addOverlays(intermediatePointsCircles)
    }
    
    private func zoomOverPolyline(targetPolyline: MKPolyline) {
        mapView.setVisibleMapRect(targetPolyline.boundingMapRect,
                                  edgePadding: UIEdgeInsetsMake(60, 40, 10, 40),
                                  animated: false)
    }
    
}

extension ShowJourneyRoadmapViewController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        _redrawIntermediatePointCircles(mapView: mapView, cameraAltitude: mapView.camera.altitude)
    }
    
    public func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let sectionPolyline = overlay as? SectionPolyline {
            let polylineRenderer = MKPolylineRenderer(polyline: sectionPolyline)
            polylineRenderer.lineWidth = sectionPolyline.sectionLineWidth
            polylineRenderer.strokeColor = sectionPolyline.sectionStrokeColor
            if let sectionLineDashPattern = sectionPolyline.sectionLineDashPattern {
                polylineRenderer.lineDashPattern = sectionLineDashPattern
            }
            if let sectionLineCap = sectionPolyline.sectionLineCap {
                polylineRenderer.lineCap = sectionLineCap
            }
            
            return polylineRenderer
        } else if let circle = overlay as? SectionCircle {
            let circleRenderer = MKCircleRenderer(circle: circle)
            circleRenderer.lineWidth = 1.5
            circleRenderer.strokeColor = circle.sectionBackgroundColor
            circleRenderer.fillColor = UIColor.white
            
            return circleRenderer
        }
        
        return MKOverlayRenderer()
    }
    
    public func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let customAnnotation = annotation as? CustomAnnotation {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: customAnnotation.identifier)
            if annotationView == nil {
                annotationView = customAnnotation.getAnnotationView(annotationIdentifier: customAnnotation.identifier, bundle: NavitiaSDKUI.shared.bundle)
            } else {
                annotationView?.annotation = annotation
            }
            
            return annotationView
        } else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationViewIdentifier")
            annotationView?.annotation = annotation
            
            return annotationView
        }
    }
    
}

extension ShowJourneyRoadmapViewController: AlertViewControllerProtocol {
    
    func onNegativeButtonClicked(_ alertViewController: AlertViewController) {
        alertViewController.dismiss(animated: false, completion: nil)
    }
    
    func onPositiveButtonClicked(_ alertViewController: AlertViewController) {
        openDeepLink()
        alertViewController.dismiss(animated: false, completion: nil)
    }
    
}

extension ShowJourneyRoadmapViewController: CLLocationManagerDelegate {
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            startUpdatingUserLocation()
        }
    }
    
    private func startUpdatingUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    private func stopUpdatingUserLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.stopUpdatingLocation()
        }
    }
    
}
