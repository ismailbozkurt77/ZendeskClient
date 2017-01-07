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
        //TODO: use localized string fro status
        statusLabel.text = ticketViewModel.status?.rawValue
        idLabel.text = ticketViewModel.ticketId
        subjectLabel.text = ticketViewModel.subject
        descriptionLabel.text = ticketViewModel.ticketDescription
    }

}
