//
//  Ticket.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit
import ObjectMapper

enum TicketStatus: String {
    case new = "new"
    case open = "open"
    case pending = "pending"
}


class Ticket: NSObject, Mappable {
    var status: TicketStatus?
    var ticketDescription: String?
    var subject: String?
    var ticketId: Int?
    
    
    // MARK: - Mappable
    
    required init?(map: Map) {
        
    }
    
    override init() {
        // For mocking purpose only
    }
    
    func mapping(map: Map) {
        subject             <- map["subject"]
        ticketDescription   <- map["description"]
        status              <- (map["status"], EnumTransform<TicketStatus>())
        ticketId            <- map["id"]
    }
}
