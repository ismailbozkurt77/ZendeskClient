//
//  TicketListDefaultInteractor.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit

class TicketListDefaultInteractor: NSObject, TicketListInteractor {
    private var service: TicketService
    private var onGoingDataTasks = [URLSessionTask]()
    init(service: TicketService) {
        self.service = service
    }
    
    // MARK: - TicketListInteractor
    func fetchTickets(completion: @escaping TicketServiceFetchTicketCompletion) {
        let dataTask = self.service.fetchTickets(sortBy: .status, ascending: false, completion: completion)
        self.onGoingDataTasks.append(dataTask)
    }
    
    func cancelFetchTicketCalls() {
        self.onGoingDataTasks.forEach { $0.cancel() }
        self.onGoingDataTasks.removeAll()
    }
}
