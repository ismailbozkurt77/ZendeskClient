//
//  CLP_TicketTableViewController.m
//  Zendesk Exercise
//

#import "CLP_TicketTableViewController.h"

@interface CLP_TicketTableViewController ()

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSString *serverURL;

@end

@implementation CLP_TicketTableViewController

- (NSString *)serverURL
{
    return @"https://mxtechtest.zendesk.com/api/v2/views/39551161/tickets.json";
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // only want one section to display data in this case
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}


- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"acooke+techtest@zendesk.com"
                                                                    password:@"mobile"
                                                                 persistence:NSURLCredentialPersistenceForSession];
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *error;
    NSDictionary *ticketsData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    self.dataArray = [ticketsData objectForKey:@"tickets"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ZendeskTicketDataRefreshed" object:self];
}


- (void)fetchTicketsFromServer
{
    NSURL *url = [[NSURL alloc]initWithString:self.serverURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary *entry = self.dataArray[indexPath.row];
    NSString *mainLabel = [NSString stringWithFormat:@"%i",[[entry objectForKey:@"id"] intValue]];
    mainLabel = [mainLabel stringByAppendingString:@"\t"];
    mainLabel = [mainLabel stringByAppendingString:[entry objectForKey:@"subject"]];
    
    NSString *secondaryLabel = [[entry objectForKey:@"description"] stringByAppendingString:@"\t"];
    secondaryLabel = [secondaryLabel stringByAppendingString:[entry objectForKey:@"status"]];
    
    cell.textLabel.text = mainLabel;
    cell.detailTextLabel.text = secondaryLabel;
    
    return cell;
}

@end
