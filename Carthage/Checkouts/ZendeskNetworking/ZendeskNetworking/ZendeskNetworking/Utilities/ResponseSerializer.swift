//
//  ResponseSerializer.swift
//  ZendeskNetworking
//
//  Created by Ismail on 06/01/2017.
//  Copyright © 2017 Ismail Bozkurt. All rights reserved.
//

import Foundation


let kResponseSerializerErrorDomain = "com.ismail.bozkurt.com.serializer.error"
let kResponseSerializerErrorCode = -666

let kResponseSerializerResponseStatusCodeKey = "statusCode"


class ResponseSerializer: NSObject {
    
    fileprivate let acceptableStatusCodes: IndexSet

    override init() {
        var statusCodes: [Int] { return Array(200..<300) }
        acceptableStatusCodes = IndexSet(statusCodes)
    }
    
    @discardableResult
    public func validate(response: URLResponse?, data: Data?, error: inout Error?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            return true
        }

        var responseIsValid = true

        if !acceptableStatusCodes.contains(httpResponse.statusCode), let url = httpResponse.url?.absoluteString {
            let localizedDescriptionKey = "Request Failed: \(HTTPURLResponse.localizedString(forStatusCode:httpResponse.statusCode))"
            let userInfo = [
                NSLocalizedDescriptionKey: localizedDescriptionKey,
                NSURLErrorFailingURLErrorKey: url,
                kResponseSerializerResponseStatusCodeKey: String(httpResponse.statusCode)
            ]
            
            let validationError = NSError(domain: kResponseSerializerErrorDomain, code: kResponseSerializerErrorCode, userInfo: userInfo)
            error = validationError
            
            responseIsValid = false
        }
        return responseIsValid
    }
}
