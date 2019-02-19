//
//  FormJourneyPresenter.swift
//  NavitiaSDKUI
//
//  Copyright © 2019 kisio. All rights reserved.
//

import UIKit

protocol FormJourneyPresentationLogic {

    func presentDisplayedSearch(response: FormJourney.DisplaySearch.Response)
}

class FormJourneyPresenter: FormJourneyPresentationLogic {
    
    weak var viewController: FormJourneyDisplayLogic?
    
    func presentDisplayedSearch(response: FormJourney.DisplaySearch.Response) {
        let viewModel = FormJourney.DisplaySearch.ViewModel(fromName: response.journeysRequest.originName ?? response.journeysRequest.originLabel ?? response.journeysRequest.originId,
                                                            toName: response.journeysRequest.destinationName ?? response.journeysRequest.destinationLabel ?? response.journeysRequest.destinationId)
        
        viewController?.displaySearch(viewModel: viewModel)
    }
}
