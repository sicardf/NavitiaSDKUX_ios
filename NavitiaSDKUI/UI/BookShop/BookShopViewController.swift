//
//  BookShopViewController.swift
//  NavitiaSDKUI
//
//  Created by Flavien Sicard on 23/04/2018.
//  Copyright © 2018 kisio. All rights reserved.
//

import UIKit

open class BookShopViewController: UIViewController {

    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var breadcrumbContainerView: BreadcrumbView!
    @IBOutlet weak var validateBasketContainerView: UIView!
    @IBOutlet weak var validateBasketContainerHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var typeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var collectionViewBottomContraint: NSLayoutConstraint!
    
    private var _validateBasketView: ValidateBasketView!
    private var _breadcrumbView: BreadcrumbView!
    private var _validateBasketHeight: CGFloat = 50
    
    fileprivate var _viewModel: BookShopViewModel! {
        didSet {
            self._viewModel.bookShopDidChange = { [weak self] bookShopViewModel in
                self?.collectionView.reloadData()
                if NavitiaSDKPartners.shared.cart.isEmpty {
                    self?._animationValidateBasket(animated: true, hidden: true)
                } else {
                    self?._animationValidateBasket(animated: true, hidden: false)
                    self?._validateBasketView.setAmount(NavitiaSDKPartners.shared.cartTotalPrice, currency: "E")
                }
//                if bookShopViewModel.didDisplayValidateTicket() {
//                    self?._animationValidateBasket(animated: true, hidden: false)
//                } else {
//                    self?._animationValidateBasket(animated: true, hidden: true)
//                }
            }
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        NavitiaSDKUI.shared.bundle = self.nibBundle
        UIFont.registerFontWithFilenameString(filenameString: "SDKIcons.ttf", bundle: NavitiaSDKUI.shared.bundle)
        
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
        
        _setupInterface()
        _registerCollectionView()
        _viewModel = BookShopViewModel()
        _viewModel.request()

    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override open func viewDidLayoutSubviews() {
        if #available(iOS 11.0, *) {
            validateBasketContainerHeightContraint.constant = _validateBasketHeight + view.safeAreaInsets.bottom
        }
    }
    
    private func _registerCollectionView() {
        collectionView.register(UINib(nibName: TicketCollectionViewCell.identifier, bundle: self.nibBundle), forCellWithReuseIdentifier: TicketCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: TicketLoadCollectionViewCell.identifier, bundle: self.nibBundle), forCellWithReuseIdentifier: TicketLoadCollectionViewCell.identifier)
    }
    
    private func _setupInterface() {
        statusBarView.backgroundColor = Configuration.Color.main
        validateBasketContainerView.backgroundColor = Configuration.Color.main
        _animationValidateBasket(animated: false, hidden: true)
        
        _setupBreadcrumbView()
        _setupValidateBasketView()
        _setupTypeSegmentedControl()
    }
    
    private func _setupBreadcrumbView() {
        _breadcrumbView = BreadcrumbView()
        _breadcrumbView.delegate = self
        _breadcrumbView.stateBreadcrumb = .shop
        _breadcrumbView.translatesAutoresizingMaskIntoConstraints = false
        breadcrumbContainerView.addSubview(_breadcrumbView)
        
        NSLayoutConstraint(item: _breadcrumbView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: breadcrumbContainerView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: _breadcrumbView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: breadcrumbContainerView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: _breadcrumbView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: breadcrumbContainerView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: _breadcrumbView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: breadcrumbContainerView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    private func _setupValidateBasketView() {
        _validateBasketView = ValidateBasketView()
        _validateBasketView.delegate = self
        _validateBasketView.translatesAutoresizingMaskIntoConstraints = false
        validateBasketContainerView.addSubview(_validateBasketView)
        
        NSLayoutConstraint(item: _validateBasketView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: validateBasketContainerView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: _validateBasketView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: _validateBasketHeight).isActive = true
        NSLayoutConstraint(item: _validateBasketView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: validateBasketContainerView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: _validateBasketView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: validateBasketContainerView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0).isActive = true
    }
    
    private func _setupTypeSegmentedControl() {
        typeSegmentedControl.tintColor = Configuration.Color.main
        typeSegmentedControl.setTitle("Titres unitaires".localized(withComment: "Titres unitaires", bundle: NavitiaSDKUI.shared.bundle), forSegmentAt: 0)
        typeSegmentedControl.setTitle("Abonnements".localized(withComment: "Abonnements", bundle: NavitiaSDKUI.shared.bundle), forSegmentAt: 1)
    }
    
    private func _animationValidateBasket(animated: Bool, hidden: Bool) {
        var duration = 0.0
        if animated {
            duration = 0.4
        }
        if hidden {
            self.collectionViewBottomContraint.constant = 0
            UIView.animate(withDuration: duration, animations: {
                self.validateBasketContainerView.alpha = 0
            }, completion: {
                (value: Bool) in
                self.validateBasketContainerView.isHidden = true
            })
        } else {
            collectionViewBottomContraint.constant = validateBasketContainerHeightContraint.constant
            validateBasketContainerView.isHidden = false
            UIView.animate(withDuration: duration, animations: {
                self.validateBasketContainerView.alpha = 1
            }, completion: {
                (value: Bool) in
            })
        }
    }

    @IBAction func onTypePressedSegmentControl(_ sender: UISegmentedControl) {
        self._viewModel.bookShopDidChange!(self._viewModel)
    }
    
}

extension BookShopViewController: UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if _viewModel.loading {
            return 4
        }
        return _viewModel.bookOffer[typeSegmentedControl.selectedSegmentIndex].count
//        if typeSegmentedControl.selectedSegmentIndex == 1 {
//            return _viewModel.memberships.count
//        }
//        return _viewModel.tickets.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if _viewModel.loading {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketLoadCollectionViewCell.identifier, for: indexPath) as? TicketLoadCollectionViewCell {
                return cell
            }
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TicketCollectionViewCell.identifier, for: indexPath) as? TicketCollectionViewCell {
            cell.title = _viewModel.bookOffer[typeSegmentedControl.selectedSegmentIndex][indexPath.row].title
            cell.setPrice(_viewModel.bookOffer[typeSegmentedControl.selectedSegmentIndex][indexPath.row].price,
                          currency: _viewModel.bookOffer[typeSegmentedControl.selectedSegmentIndex][indexPath.row].currency)
            cell.descript = _viewModel.bookOffer[typeSegmentedControl.selectedSegmentIndex][indexPath.row].shortDescription
            cell.id = _viewModel.bookOffer[typeSegmentedControl.selectedSegmentIndex][indexPath.row].id
            cell.maxQuantity = _viewModel.bookOffer[typeSegmentedControl.selectedSegmentIndex][indexPath.row].maxQuantity
            //print(NavitiaSDKPartners.shared.cart.filter({ $0.bookOffer.productId == cell.id }))
            let test = NavitiaSDKPartners.shared.cart.filter({ $0.bookOffer.id == cell.id })
            print(test.first?.quantity)
//            {
               cell.amount = test.first?.quantity ?? 0
//            } else {
//                cell.amount = 0
//            }
            
//            if typeSegmentedControl.selectedSegmentIndex == 1 {
////                cell.title = _viewModel.abonnement[indexPath.row].name
////                cell.amount = _viewModel.abonnement[indexPath.row].count
////                cell.setPrice(0.00, currency: "E")
////                cell.descript = "[DESCRIPTION]"
//                cell.title = _viewModel.memberships[indexPath.row].title
//                cell.setPrice(_viewModel.memberships[indexPath.row].price, currency: _viewModel.memberships[indexPath.row].currency)
//                cell.descript = _viewModel.memberships[indexPath.row].shortDescription
//              //  cell.amount = _viewModel.abonnement[indexPath.row].count
//            } else {
//                cell.title = _viewModel.tickets[indexPath.row].title
//                cell.setPrice(_viewModel.tickets[indexPath.row].price, currency: _viewModel.tickets[indexPath.row].currency)
//                cell.descript = _viewModel.tickets[indexPath.row].shortDescription
//                cell.amount = _viewModel.ticket[indexPath.row].count
//            }
            cell.delegate = self
            cell.indexPath = indexPath
            
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension BookShopViewController: UICollectionViewDelegate {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
    
}

extension BookShopViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var safeAreaWidth: CGFloat = 20.0
        if #available(iOS 11.0, *) {
            safeAreaWidth += self.collectionView.safeAreaInsets.left + self.collectionView.safeAreaInsets.right
        }
        return CGSize(width: self.collectionView.frame.size.width - safeAreaWidth, height: 110)
    }
    
}

extension BookShopViewController: BreadcrumbViewProtocol {
    
    func onDismissButtonClicked(_ BreadcrumbView: BreadcrumbView) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension BookShopViewController: TicketCollectionViewCellDelegate {
    
    func onInformationPressedButton(_ ticketCollectionViewCell: TicketCollectionViewCell) {}
    
    func onAddBasketPressedButton(_ ticketCollectionViewCell: TicketCollectionViewCell) {
        NavitiaSDKPartners.shared.addOffer(offerId: ticketCollectionViewCell.id, callbackSuccess: {
            print(NavitiaSDKPartners.shared.cartTotalPrice)
            self._viewModel.bookShopDidChange!(self._viewModel)
        }) { (codeStatus, data) in
            print("😭")
        }
    }
    
    func onLessAmountPressedButton(_ ticketCollectionViewCell: TicketCollectionViewCell) {
        NavitiaSDKPartners.shared.removeOffer(offerId: ticketCollectionViewCell.id, callbackSuccess: {
            print(NavitiaSDKPartners.shared.cartTotalPrice)
            self._viewModel.bookShopDidChange!(self._viewModel)
        }) { (codeStatus, data) in
            print("😭")
        }
    }
    
    func onMoreAmountPressendButton(_ ticketCollectionViewCell: TicketCollectionViewCell) {
        NavitiaSDKPartners.shared.addOffer(offerId: ticketCollectionViewCell.id, callbackSuccess: {
            print(NavitiaSDKPartners.shared.cartTotalPrice)
            self._viewModel.bookShopDidChange!(self._viewModel)
        }) { (codeStatus, data) in
            print("😭")
        }
    }

}

extension BookShopViewController: ValidateBasketViewDelegate {
    
    func onValidateButtonClicked(_ validateBasketView: ValidateBasketView) {}
    
}

