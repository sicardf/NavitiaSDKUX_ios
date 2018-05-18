//
//  BookPaymentWebViewController.swift
//  NavitiaSDKUI
//
//  Created by Flavien Sicard on 03/05/2018.
//  Copyright © 2018 kisio. All rights reserved.
//

import UIKit

class BookPaymentWebViewController: UIViewController {

    @IBOutlet weak var statusBarView: UIView!
    @IBOutlet weak var breadcrumbContainerView: UIView!
    @IBOutlet var webView: UIWebView!
    
    private var _breadcrumbView: BreadcrumbView!
    var request: URLRequest?
    var viewModel: BookPaymentViewModel?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        _setupBreadcrumbView()
        _setupWebView()
        statusBarView.backgroundColor = Configuration.Color.main
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private func _setupWebView() {
        webView.delegate = self
        webView.scrollView.bounces = false
        guard let request = request else {
            return
        }
        webView.loadRequest(request)
    }
    
    private func _setupBreadcrumbView() {
        _breadcrumbView = BreadcrumbView()
        _breadcrumbView.delegate = self
        _breadcrumbView.stateBreadcrumb = .payment
        _breadcrumbView.translatesAutoresizingMaskIntoConstraints = false
        breadcrumbContainerView.addSubview(_breadcrumbView)
        
        NSLayoutConstraint(item: _breadcrumbView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: breadcrumbContainerView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: _breadcrumbView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: breadcrumbContainerView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: _breadcrumbView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: breadcrumbContainerView, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: _breadcrumbView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: breadcrumbContainerView, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0).isActive = true
    }

}

extension BookPaymentWebViewController: BookShopViewControllerDelegate {
    
    func onDismissBookShopViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension BookPaymentWebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let html = webView.stringByEvaluatingJavaScript(from: "document.getElementsByTagName('html')[0].innerHTML")
        if let transactionSogenActif = html?.extractTransactionSogenActif() {
            print("ID : \(transactionSogenActif)")
        }
        if let customerSogenActif = html?.extractCustomerSogenActif() {
            print("ID : \(customerSogenActif)")
        }
    }
    
    public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let url = request.url?.absoluteString {
            switch NavitiaSDKPartnersSogenActif.getReturnValue(url: url) {
            case .success:
                print("Result : ✅ Success")
            case .error:
                dismiss(animated: true) {
                    if let returnPayment = self.viewModel?.returnPayment { returnPayment() }
                }
            case .cancel:
                dismiss(animated: true) {}
            case .unknown:
                break
            }
        }
        return true
    }
    
}

