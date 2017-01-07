//
//  TicketService.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import Foundation

typealias TicketServiceFetchTicketCompletion = ([Ticket]?, Error?) -> Void

protocol TicketService {
    
    @discardableResult
    func fetchTickets(completion: @escaping TicketServiceFetchTicketCompletion) -> URLSessionTask
}
