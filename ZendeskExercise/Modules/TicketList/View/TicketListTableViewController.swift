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
    private var activityIndicator: UIActivityIndicatorView!
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActivityIndicator()
        eventHandler.viewIsReady()
    }

    // MARK: - Setup
    
    private func setupUI() {
        title = NSLocalizedString("tickets", tableName: kStringTableCommon, comment: "Tickets")
    }
    
    private func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
        let barItem = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = nil
        navigationItem.rightBarButtonItem = barItem
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
        activityIndicator.startAnimating()
    }
    
    func dismissLoading() {
        activityIndicator.stopAnimating()
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
        let title = NSLocalizedString("fetch.tickets.failed.title", tableName: kStringTableTicketsList, comment: "")
        let alertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let cancelTitle = NSLocalizedString("cancel", tableName: kStringTableCommon, comment: "cancel")
        let action = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(action)
        
        let retryTitle = NSLocalizedString("try.again", tableName: kStringTableCommon, comment: "try again")
        let retryAction = UIAlertAction(title: retryTitle, style: .default, handler:{ (action: UIAlertAction) in
            // TODO
        })
        alertController.addAction(retryAction)
        
        return alertController
    }
}
