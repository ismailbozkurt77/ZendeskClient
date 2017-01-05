//
//  CLP_TicketTableViewController.h
//  Zendesk Exercise
//

#import <UIKit/UIKit.h>

@interface CLP_TicketTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

- (void)fetchTicketsFromServer;

@end
