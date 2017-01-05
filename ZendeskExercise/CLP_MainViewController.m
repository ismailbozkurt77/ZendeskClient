//
//  CLP_MainViewController.m
//  Zendesk Exercise
//

#import "CLP_MainViewController.h"
#import "CLP_TicketTableViewController.h"

@interface CLP_MainViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) CLP_TicketTableViewController *tableViewController;

@end

@implementation CLP_MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // register as an observer for notifications that the data for the table has been refreshed
    [[NSNotificationCenter defaultCenter] addObserverForName:@"ZendeskTicketDataRefreshed" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [self.tableView reloadData];
    }];
    
    // add table subview controller for tickets
    self.tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.tableViewController = [[CLP_TicketTableViewController alloc]init];
    
    self.tableView.delegate = self.tableViewController;
    self.tableView.dataSource = self.tableViewController;
    
    [self.view addSubview:self.tableView];
    
    [self.tableViewController fetchTicketsFromServer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // remove self as observer of notifications before dealloc
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
