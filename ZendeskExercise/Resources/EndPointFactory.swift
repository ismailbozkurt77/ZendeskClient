//
//  EndPointFactory.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit

private let kEndPointInfoFileName = "EndPoints.plist"
private let kRootEndPointKey = "root"


class EndPointFactory: NSObject {
    private class func endpointDictionary() -> [String: String]? {
        
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        
        let plistPath = Bundle.main.path(forResource: kEndPointInfoFileName, ofType: nil)
        guard let plistXML = FileManager.default.contents(atPath: plistPath!) else {
            return nil
        }
        
        var plist: [String: String]?
        
        do {
            plist = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String: String]
            
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
            return nil
        }
        
        return plist
    }
    
    class public func baseUrl() -> URL {
        let rootEndPoint = self.endpointDictionary()?[kRootEndPointKey]!
        return URL(string: rootEndPoint!)!
    }
}
