//
//  TicketMapperTests.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import XCTest

class TicketMapperTests: XCTestCase {
    var mapper: TicketMapper!
    var ticketModelMock: Ticket!
    var numberFormatterMock: NumberFormatter!
    
    override func setUp() {
        super.setUp()
        self.mapper = TicketMapper()
        
        self.ticketModelMock = Ticket()
        self.ticketModelMock.status = "New"
        self.ticketModelMock.ticketDescription = "Zeneks service ticket"
        self.ticketModelMock.ticketId = 66666
        self.ticketModelMock.subject = "this is a test"
        
        self.numberFormatterMock = NumberFormatter()
        self.numberFormatterMock.numberStyle = .decimal
    }

    func testTicketViewModelMapper() {
        let ticketViewModel = self.mapper.ticketViewModel(model: ticketModelMock)
        

        XCTAssertTrue(ticketViewModel.status == self.ticketModelMock.status)
        XCTAssertTrue(ticketViewModel.ticketDescription == self.ticketModelMock.ticketDescription)
        XCTAssertTrue(ticketViewModel.subject == self.ticketModelMock.subject)
        
        let number = self.numberFormatterMock.string(from: NSNumber(value: self.ticketModelMock.ticketId!))
        XCTAssertTrue(number == ticketViewModel.ticketId)
    }
    
}
