//
//  RequestHeaderSerializerTests.swift
//  ZendeskNetworking
//
//  Created by Ismail on 06/01/2017.
//  Copyright © 2017 Ismail Bozkurt. All rights reserved.
//

import XCTest

class RequestSerializerTests: XCTestCase {
    var requestHeaderSerializer: RequestHeaderSerializer!
    
    override func setUp() {
        super.setUp()
        requestHeaderSerializer = RequestHeaderSerializer()
    }
    
    //ismail:bozkurt >> aXNtYWlsOmJvemt1cnQ=
    func testSetAutherizationHeader() {
        requestHeaderSerializer.setAutherizationHeader(username: "ismail", password: "bozkurt")
        XCTAssertEqual(requestHeaderSerializer.headers["Authorization"], "Basic aXNtYWlsOmJvemt1cnQ=")
    }
}
