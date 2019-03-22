//
//  ListJourneysViewControllerTests.swift
//  TravelUITests
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import XCTest
import UIKit
@testable import TravelUI

class ListJourneysViewControllerTests: XCTestCase {
    
    var sut: ListJourneysViewController!
    var storyboard: UIStoryboard!
    
    override func setUp() {
        super.setUp()
        
        setupTravelUI()
        setupListJourneysViewController()
    }
    
    func setupTravelUI() {
        TravelUI.shared.bundle = Bundle(identifier: "com.sicardf.TravelUI")
        TravelUI.shared.originColor = UIColor.blue
        TravelUI.shared.destinationColor = UIColor.brown
    }
    
    func setupListJourneysViewController() {
        storyboard = UIStoryboard(name: "Journey", bundle: TravelUI.shared.bundle)
        sut = storyboard.instantiateInitialViewController() as! ListJourneysViewController
        
        sut.journeysRequest = JourneysRequest(originId: "2.3665844;48.8465337", destinationId: "2.2979169;48.8848719")
        
        _ = sut.view
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSUT_CanInstantiateViewController() {
        XCTAssertNotNil(sut)
    }
    
    func testSUT_CollectionViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.journeysCollectionView)
        XCTAssertEqual(sut.journeysCollectionView.numberOfSections, 1)
    }
    
    func testColorHeader() {
        XCTAssertEqual(sut.fromPinLabel.textColor, .blue)
        XCTAssertEqual(sut.toPinLabel.textColor, .brown)
    }
}
