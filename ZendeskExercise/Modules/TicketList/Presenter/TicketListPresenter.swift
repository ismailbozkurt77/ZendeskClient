//
//  TicketListPresenter.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit

class TicketListPresenter: NSObject, TicketListEventHandler {
    
    // MARK: - Properties
    var interactor: TicketListInteractor
    weak var view: TicketListView?
    private let mapper = TicketMapper()
    
    // MARK: - Lifecycle
    init(view: TicketListView, interactor: TicketListInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    // MARK: - <TicketListEventHandler>
    func viewIsReady() {
        self.processTickets()
    }
    
    // MARK: - Private Helpers
    func processTickets() {
        self.view?.displayLoading()
        self.interactor.fetchTickets { [weak self] (tickets: [Ticket]?, error: Error?) in
            self?.view?.dismissLoading()
            
            if error == nil && tickets != nil {
                let tickets = self?.mapper.ticketViewModelArray(models: tickets!)
                self?.view?.displayTickets(tickets)
            }
            else if error != nil {
                self?.view?.displayError(error: error!)
            }
        }
    }
}
