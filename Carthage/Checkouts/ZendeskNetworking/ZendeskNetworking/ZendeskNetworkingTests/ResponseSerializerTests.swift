//
//  ResponseSerializerTests.swift
//  ZendeskNetworking
//
//  Created by Ismail on 06/01/2017.
//  Copyright © 2017 Ismail Bozkurt. All rights reserved.
//

import XCTest

class ResponseSerializerTests: XCTestCase {
    var responseSerializer: ResponseSerializer!
    
    override func setUp() {
        super.setUp()
        responseSerializer = ResponseSerializer()
    }
    
    func testValidate() {
        let httpResponseMock = HTTPURLResponse(url: URL(string: "http://google.com")!,
                                               statusCode: 401,
                                               httpVersion: "HTTP/1.1",
                                               headerFields: nil)
     
        var error: Error? = nil
        let isValid = responseSerializer.validate(response: httpResponseMock, data: nil, error: &error)
        
        XCTAssertFalse(isValid)
    }
    
}
