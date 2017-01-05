//
//  ZendeskNetworkingTests.swift
//  ZendeskNetworkingTests
//
//  Created by Ismail on 05/01/2017.
//  Copyright © 2017 Ismail Bozkurt. All rights reserved.
//

import XCTest
@testable import ZendeskNetworking

class ZendeskNetworkingTests: XCTestCase {
    var restClient: UrlSessionRestClient!
    
    override func setUp() {
        super.setUp()
        restClient = UrlSessionRestClient()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = self.expectation(description: "HTTP GET call")
        let url = URL(string: "https://mxtechtest.zendesk.com/api/v2/views/39551161/tickets.json")
        restClient.GET(url: url!, headers: nil, completion: { (data: Data?, response: URLResponse?, error: Error?) in
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 60, handler: { (error: Error?) in
            
        })
    }
}
