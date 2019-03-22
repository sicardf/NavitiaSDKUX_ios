//
//  AlternativeJourney.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import UIKit

protocol AlternativeJourneyDelegate: class {
    
    func avoidJourney()
}

class AlternativeJourneyView: UIView {
    
    @IBOutlet weak var friezeView: FriezeView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avoidDisruptionButton: UIButton!
    @IBOutlet weak var accessibilityButton: UIButton!
    
    internal weak var delegate: AlternativeJourneyDelegate?
    
    // MARK: - UINib
    
    static var identifier: String {
        return String(describing: self)
    }
    
    class func instanceFromNib() -> AlternativeJourneyView {
        return UINib(nibName: identifier, bundle: TravelUI.shared.bundle).instantiate(withOwner: nil, options: nil)[0] as! AlternativeJourneyView
    }
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateFriezeView()
    }
    
    // MARK: - Function
    
    private func setup() {
        descriptionLabel.text = "itinerary_disruption_message".localized()
        avoidDisruptionButton.setTitle("avoid_the_disruption".localized(), for: .normal)
        accessibilityButton.accessibilityLabel = ""
    }
    
    internal func addFrieze(friezeSection: [FriezePresenter.FriezeSection]) {
        friezeView.addSection(friezeSections: friezeSection)
        friezeView.getCenter()
        
        frame.size.height = friezeView.frame.size.height + 83
    }
    
    private func updateFriezeView() {
        friezeView.frame.size = CGSize(width: frame.size.width, height: 27)
        friezeView.updatePositionFriezeSectionView()
        friezeView.getCenter()
        
        frame.size.height = friezeView.frame.size.height + 83
    }
    
    // MARK: - Action
    
    @IBAction func avoidJourneyButton(_ sender: UIButton) {
        delegate?.avoidJourney()
    }
}
