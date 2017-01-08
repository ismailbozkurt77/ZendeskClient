//
//  TicketCell.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit

class TicketCell: UITableViewCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateContent(ticketViewModel: TicketViewModel) {
        let statusText: String!
        switch ticketViewModel.status {
        case .new?:
            statusText = NSLocalizedString("new", tableName: kCommonStringTable, comment: "new")
        case .open?:
            statusText = NSLocalizedString("open", tableName: kCommonStringTable, comment: "pending")
        case .pending?:
            statusText = NSLocalizedString("pending", tableName: kCommonStringTable, comment: "pending")
        default:
            statusText = ""
        }
        statusLabel.text = statusText
        
        idLabel.text = ticketViewModel.ticketId
        
        subjectLabel.text = ticketViewModel.subject
        
        descriptionLabel.text = ticketViewModel.ticketDescription
    }

}
