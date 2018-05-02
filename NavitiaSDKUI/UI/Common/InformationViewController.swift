//
//  InformationViewController.swift
//  NavitiaSDKUI
//
//  Copyright © 2018 kisio. All rights reserved.
//

import UIKit

@objc protocol InformationViewDelegate {
    
    func onFirstButtonClicked(_ informationViewController: InformationViewController)
    @objc optional func onSecondButtonClicked(_ informationViewController: InformationViewController)
    
}

class InformationViewController: UIViewController {
 
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var iconContainerView: UIView!
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet var secondLineView: UIView!
    @IBOutlet var secondButton: UIButton!
    
    var delegate: InformationViewDelegate?
    var titleButton = ["OK"]
    var information: String = ""
    var iconName: String = "information"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false

        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self._dismissView)))
        if titleButton.count > 1 {
            secondButton.setAttributedTitle(NSMutableAttributedString()
                .normal(titleButton[1],
                      color: Configuration.Color.gray,
                      size: 12),
                                           for: .normal)
        } else {
            secondLineView.removeFromSuperview()
            secondButton.removeFromSuperview()
        }
        firstButton.setAttributedTitle(NSMutableAttributedString()
            .bold(titleButton.first!,
                  color: Configuration.Color.main,
                  size: 12),
                                       for: .normal)
        descriptionLabel.attributedText = NSMutableAttributedString()
            .normal(information,
                    color: Configuration.Color.darkGray,
                    size: 12)
        iconContainerView.backgroundColor = Configuration.Color.main
        iconLabel.attributedText = NSMutableAttributedString()
            .icon(iconName,
                    color: Configuration.Color.white,
                    size: 20)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
      //  isHiddenSecondButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onFirstButtonClicked(_ sender: UIButton) {
        delegate?.onFirstButtonClicked(self)
    }
    
    @IBAction func onSecondButtonClicked(_ sender: UIButton) {
        if delegate?.onSecondButtonClicked != nil {
            delegate?.onSecondButtonClicked!(self)
        }
    }
    
    @objc private func _dismissView() {
        dismiss(animated: true, completion: nil)
    }

}

extension InformationViewController {
    
}
