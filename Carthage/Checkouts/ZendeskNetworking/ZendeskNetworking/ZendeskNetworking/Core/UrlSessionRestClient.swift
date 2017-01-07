//
//  UrlSessionRestClient.swift
//  ZendeskNetworking
//
//  Created by Ismail on 05/01/2017.
//  Copyright © 2017 Ismail Bozkurt. All rights reserved.
//

import Foundation


public class UrlSessionRestClient: NSObject, RestClient {
    let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    @discardableResult
    public func GET(url: URL, headers: [String : String]?, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        var request = URLRequest(url: url)
        
        if let headers = headers {
            for key in headers.keys {
                let value = headers[key]
                request.addValue(value!, forHTTPHeaderField: key)
            }
        }
        
        let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            var error = error
            ResponseSerializer().validate(response: response, data: data, error: &error)
            completion(data, response, error)
        })
        dataTask.resume()
        
        return dataTask
    }
}
