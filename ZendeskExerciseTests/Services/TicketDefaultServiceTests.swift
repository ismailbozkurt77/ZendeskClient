//
//  TicketDefaultServiceTests.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import XCTest
import ZendeskNetworking


class TicketDefaultServiceTests: XCTestCase {
    var restClientMock: RestClient?
    var service: TicketDefaultService?
    
    override func setUp() {
        super.setUp()
        restClientMock = UrlSessionRestClient()
        service = TicketDefaultService(restClient: restClientMock!)
    }
    
    func testFetchTickets() {
        let expectation = self.expectation(description: "Fetch Tickets")
        
        self.service?.fetchTickets(completion: { (tickets: [Ticket]?, error: Error?) in
            
            let expectedCombination = ((tickets != nil) && (error == nil)) ||
                                      ((tickets == nil) && (error != nil))
            
            XCTAssertTrue(expectedCombination)
            
            expectation.fulfill()
        })
        
        
        self.waitForExpectations(timeout: 120, handler: { (error: Error?) in
        
        })
    }
    
}
