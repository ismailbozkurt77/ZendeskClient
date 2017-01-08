//
//  TicketService.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import Foundation

typealias TicketServiceFetchTicketCompletion = ([Ticket]?, Error?) -> Void


enum TicketSortOrderOption {
    case id
    case status
    case subject
}


protocol TicketService {
    
    @discardableResult
    func fetchTickets(sortBy: TicketSortOrderOption, ascending: Bool, completion: @escaping TicketServiceFetchTicketCompletion) -> URLSessionTask
}

extension TicketService {
    func fetchTickets(sortBy: TicketSortOrderOption = .id,
                      ascending: Bool = true,
                      completion: @escaping TicketServiceFetchTicketCompletion) -> URLSessionTask{
        return self.fetchTickets(sortBy: sortBy, ascending: ascending, completion: completion)
    }
}
