//
//  RequestHeaderSerializer.swift
//  ZendeskNetworking
//
//  Created by Ismail on 06/01/2017.
//  Copyright © 2017 Ismail Bozkurt. All rights reserved.
//

import Foundation


public class RequestHeaderSerializer: NSObject {
    lazy public var headers = [String: String]()
    
    public func setAutherizationHeader(username: String, password: String) {
        let basicAuthCredentials = "\(username):\(password)"
        let authData = basicAuthCredentials.data(using: String.Encoding.utf8)
        let base64Auth = authData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        let authKey = "Authorization"
        guard let base64AuthSafe: String = base64Auth else {
            headers[authKey] = nil
            return
        }
        headers[authKey] = "Basic \(base64AuthSafe)"
    }
}
