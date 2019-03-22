//
//  ViewController.swift
//  TravelUI-Example
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import UIKit
import TravelUI

class ViewController: UIViewController {
    
    let coverage = "fr-idf"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func getListJourneysViewController() -> UIViewController? {
        TravelUI.shared.formJourney = false
        
        guard let journeyResultsViewController = TravelUI.shared.rootViewController else {
            return nil
        }
        
        let journeysRequest = JourneysRequest(coverage: coverage)
        journeysRequest.originId = "2.3665844;48.8465337"
        journeysRequest.originLabel = "Chez moi"
        journeysRequest.destinationId = "2.2979169;48.8848719"
        journeysRequest.destinationLabel = "Au travail"
        journeysRequest.datetime = Date()
        journeysRequest.datetime!.addTimeInterval(7200)
        journeysRequest.datetimeRepresents = .departure
        journeysRequest.forbiddenUris = ["physical_mode:Bus"]
        journeysRequest.firstSectionModes = [.walking, .car, .bike, .bss, .ridesharing]
        journeysRequest.lastSectionModes = [.walking, .car, .bike, .bss, .ridesharing]
        journeysRequest.count = 5
        
        journeyResultsViewController.journeysRequest = journeysRequest
        
        return journeyResultsViewController as? UIViewController
    }
    
    private func getFormJourneyViewController() -> UIViewController? {
        TravelUI.shared.formJourney = true
        TravelUI.shared.modeForm = [ModeButtonModel(title: "Metro", icon: "metro", selected: true, mode: .walking, physicalMode: ["physical_mode:Metro"]),
                                        ModeButtonModel(title: "Bus", icon: "bus", selected: true, mode: .walking, physicalMode: ["physical_mode:Bus"]),
                                        ModeButtonModel(title: "RER", icon: "train", selected: true, mode: .walking, physicalMode: ["physical_mode:RapidTransit"]),
                                        ModeButtonModel(title: "Tramway", icon: "tramway", selected: false, mode: .walking, physicalMode: ["physical_mode:Tramway"]),
                                        ModeButtonModel(title: "Train", icon: "train", selected: false, mode: .walking, physicalMode: ["physical_mode:LocalTrain", "physical_mode:Train"]),
                                        ModeButtonModel(title: "Navette", icon: "train", selected: false, mode: .walking, physicalMode: ["physical_mode:Shuttle"]),
                                        ModeButtonModel(title: "Bike", icon: "bike", selected: false, mode: .bike),
                                        ModeButtonModel(title: "VLS", icon: "bss", selected: false, mode: .bss, realTime: true),
                                        ModeButtonModel(title: "Car", icon: "car", selected: false, mode: .car)]
        
        guard let journeyResultsViewController = TravelUI.shared.rootViewController else {
            return nil
        }
        
        let journeysRequest = JourneysRequest(coverage: coverage)
        
        journeyResultsViewController.journeysRequest = journeysRequest
        
        return journeyResultsViewController as? UIViewController
    }
    
    @IBAction func touch(_ sender: Any) {
        if let formJourneyViewController = getFormJourneyViewController() {
            navigationController?.pushViewController(formJourneyViewController, animated: true)
        }
    }
    
    @IBAction func touchWithoutForm(_ sender: Any) {
        if let listJourneysViewController = getListJourneysViewController() {
            navigationController?.pushViewController(listJourneysViewController, animated: true)
        }
    }
}
