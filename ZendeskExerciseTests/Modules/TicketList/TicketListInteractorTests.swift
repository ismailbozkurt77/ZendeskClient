//
//  TicketListInteractorTests.swift
//  ZendeskExercise
//
//  Created by Ismail on 08/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import XCTest

class TicketListInteractorTests: XCTestCase {
    var interactor: TicketListDefaultInteractor!
    fileprivate var serviceMock: FauxTicketService!
    override func setUp() {
        super.setUp()
        serviceMock = FauxTicketService()
        interactor = TicketListDefaultInteractor(service: serviceMock)
    }
    
    func testFetchTickets() {
        interactor.fetchTickets {[weak self] (tickets: [Ticket]?, error: Error?) in
            XCTAssertTrue((self?.serviceMock.fetchTicketTriggered)!)
        }
    }
    
}

// MARK: - Mock Classes
fileprivate class FauxTicketService: TicketService {
    var fetchTicketTriggered = false
    func fetchTickets(sortBy: TicketSortOrderOption, ascending: Bool, completion: @escaping TicketServiceFetchTicketCompletion) -> URLSessionTask {
        fetchTicketTriggered = true
        
        completion(nil, nil)
        return URLSessionTask()
    }
}
