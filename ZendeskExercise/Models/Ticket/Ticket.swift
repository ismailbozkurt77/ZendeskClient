//
//  Ticket.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit
import ObjectMapper


class Ticket: NSObject, Mappable {
    var status: String?
    var ticketDescription: String?
    var subject: String?
    var ticketId: Int?
    
    
    // MARK: - Mappable
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status              <- map["status"]
        ticketDescription   <- map["description"]
        subject             <- map["subject"]
        ticketId            <- map["id"]
    }
}
