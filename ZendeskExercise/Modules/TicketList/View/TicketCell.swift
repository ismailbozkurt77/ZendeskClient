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
        
        statusLabel.font = UIFont.systemFont(ofSize: 20.0)
        idLabel.font = UIFont.systemFont(ofSize: 25.0)
        idLabel.textColor = UIColor.black
        subjectLabel.font = UIFont.systemFont(ofSize: 15.0)
        subjectLabel.textColor = UIColor.darkText
        descriptionLabel.font = UIFont.systemFont(ofSize: 12.0)
        descriptionLabel.textColor = UIColor.darkGray
    }

    func updateContent(ticketViewModel: TicketViewModel) {
        let statusText: String!
        let statusColor: UIColor!
        switch ticketViewModel.status {
        case .new?:
            statusText = NSLocalizedString("new", tableName: kStringTableCommon, comment: "new")
            statusColor = UIColor.blue
        case .open?:
            statusText = NSLocalizedString("open", tableName: kStringTableCommon, comment: "pending")
            statusColor = UIColor.green
        case .pending?:
            statusText = NSLocalizedString("pending", tableName: kStringTableCommon, comment: "pending")
            statusColor = UIColor.orange
        default:
            statusText = ""
            statusColor = UIColor.black
        }
        statusLabel.text = statusText
        statusLabel.textColor = statusColor
        
        idLabel.text = ticketViewModel.ticketId
        
        subjectLabel.text = ticketViewModel.subject
        
        descriptionLabel.text = ticketViewModel.ticketDescription
    }

}
