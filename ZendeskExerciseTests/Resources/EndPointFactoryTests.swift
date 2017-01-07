//
//  EndPointFactoryTests.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import XCTest

class EndPointFactoryTests: XCTestCase {

    func testRootEndpoint() {
        let baseUrl = EndPointFactory.baseUrl()
        XCTAssertNotNil(baseUrl)
    }
    
}
