//
//  FormJourneyModels.swift
//  TravelUI
//
//  Copyright © 2019 Flavien SICARD. All rights reserved.
//

import UIKit

enum FormJourney {
    
    // MARK: Use cases
    
    enum DisplaySearch {
        struct Request {
            var from: (label: String?, name: String?, id: String)?
            var to: (label: String?, name: String?, id: String)?
        }
        struct Response {
            var journeysRequest: JourneysRequest
        }
        struct ViewModel {
            var fromName: String?
            var toName: String?
        }
    }
    
    enum UpdateDate {
        struct Request {
            public enum DatetimeRepresents: String {
                case arrival = "arrival"
                case departure = "departure"
            }
            
            var date: Date
            var dateTimeRepresents: DatetimeRepresents
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
}
