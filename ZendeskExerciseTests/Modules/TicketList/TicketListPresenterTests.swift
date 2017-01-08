//
//  TicketListPresenterTests.swift
//  ZendeskExercise
//
//  Created by Ismail on 08/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import XCTest

class TicketListPresenterTests: XCTestCase {
    var presenter: TicketListPresenter!
    fileprivate var interactorMock: FauxTicketListInteractor!
    fileprivate var viewMock: FauxTicketListView!
    
    override func setUp() {
        super.setUp()
        viewMock = FauxTicketListView()
        interactorMock = FauxTicketListInteractor()
        self.presenter = TicketListPresenter(view: viewMock, interactor: interactorMock)
    }

    
    func testViewIsReady() {
        fetchTicketsTest()
    }
    
    func testRetry() {
        fetchTicketsTest()
    }
    
    func fetchTicketsTest() {
        presenter.viewIsReady()
        
        XCTAssertTrue(viewMock.loadingDisplayed)
        XCTAssertTrue(interactorMock.ticketsFetchTriggered)
        
        let expectation = self.expectation(description: "fetch tickets")
        
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            XCTAssertTrue(self.interactorMock.ticketsFetched)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 3) { (error: Error?) in
            
        }
    }
    
}


// MARK: - Mock Classes

fileprivate class FauxTicketListView: TicketListView {
    var loadingDismissed: Bool = false
    func dismissLoading() {
        loadingDismissed = true
    }
    
    var loadingDisplayed = false
    func displayLoading() {
        loadingDisplayed = true
    }
    
    var errorDisplayed = false
    func displayError(error: Error) {
        errorDisplayed = true
    }
    
    var ticketsDisplayed = false
    func displayTickets(_ tickets: [TicketViewModel]?) {
        ticketsDisplayed = true
    }
}

fileprivate class FauxTicketListInteractor: TicketListInteractor {
    var ticketsFetchTriggered = false
    var ticketsFetched = false
    func fetchTickets(completion: @escaping TicketServiceFetchTicketCompletion) {
        ticketsFetchTriggered = true
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.ticketsFetched = true
        }
    }
    
    func cancelFetchTicketCalls() {
        // Empty decleration
    }
}

