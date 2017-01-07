//
//  TicketMapper.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit

class TicketMapper {
    private var numberFormatter: NumberFormatter
    
    init() {
        numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
    }
    
    func ticketViewModel(model: Ticket) -> TicketViewModel {
        let viewModel = TicketViewModel()
        
        viewModel.status = model.status
        viewModel.ticketDescription = model.ticketDescription
        viewModel.subject = model.subject
        if let ticketId = model.ticketId {
            let ticketNumber = NSNumber(value: ticketId)
            viewModel.ticketId = numberFormatter.string(from: ticketNumber)
        }
        
        return viewModel
    }
}
