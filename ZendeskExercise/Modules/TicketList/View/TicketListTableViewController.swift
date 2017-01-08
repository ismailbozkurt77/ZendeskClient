//
//  TicketListTableViewController.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//

import UIKit

class TicketListTableViewController: UITableViewController, TicketListView {
    // MARK: - Properties
    var eventHandler: TicketListEventHandler!
    
    var tickets: [TicketViewModel]?
    
    private lazy var alertController = TicketListTableViewController.buildErrorAlertController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //TODO self.title
        
        self.eventHandler.viewIsReady()
    }

    // MARK: - <UITableViewDataSource>
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tickets = self.tickets {
            return tickets.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = String(describing: TicketCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TicketCell

        cell.updateContent(ticketViewModel: (self.tickets?[indexPath.row])!)

        return cell
    }
    
    // MARK: - <UITableViewDelegate>
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
 
    
    // MARK: - <TicketListView>
    
    func displayLoading() {
        // TODO
    }
    
    func dismissLoading() {
        // TODO
    }
    
    func displayError(error: Error) {
        self.alertController.message = error.localizedDescription
        self.present(self.alertController, animated: true, completion: nil)
    }

    func displayTickets(_ tickets: [TicketViewModel]?) {
        self.tickets = tickets
        self.tableView.reloadData()
    }

    // MARK: - Private Factory
    
    class func buildErrorAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: "", preferredStyle: .alert)
        // TODO: use localization in here
        let action = UIAlertAction(title: "", style: .cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
