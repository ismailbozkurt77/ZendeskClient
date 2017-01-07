//
//  CLP_TicketTableViewController.m
//  Zendesk Exercise
//

#import "CLP_TicketTableViewController.h"
#import <ZendeskNetworking/ZendeskNetworking-Swift.h>

@interface CLP_TicketTableViewController ()

@property (strong, nonatomic) NSArray *dataArray;
@property (strong, nonatomic) NSString *serverURL;
@property (strong, nonatomic) UrlSessionRestClient *restClient;

@end

@implementation CLP_TicketTableViewController

- (UrlSessionRestClient *)restClient
{
    if (!_restClient)
    {
        _restClient = [[UrlSessionRestClient alloc] init];
    }
    return _restClient;
}

- (NSString *)serverURL
{
    return @"https://mxtechtest.zendesk.com/api/v2/views/39551161/tickets.json";
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
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

- (void)fetchTicketsFromServer
{
    NSURL *url = [[NSURL alloc]initWithString:self.serverURL];

    NSDictionary<NSString *, NSString *> *headers
    = [self buildAuthorizationHeaderFieldWithUsername:@"acooke+techtest@zendesk.com" password:@"mobile"];
    [self.restClient GETWithUrl:url headers:headers completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil)
        {
            NSError *parseError;
            NSDictionary *ticketsData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            self.dataArray = [ticketsData objectForKey:@"tickets"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ZendeskTicketDataRefreshed" object:self];

        }
    }];
    
}

- (NSDictionary<NSString *, NSString *> *)buildAuthorizationHeaderFieldWithUsername:(NSString *)username
                                                                           password:(NSString *)password
{
    RequestHeaderSerializer *headerSerializer = [RequestHeaderSerializer new];
    [headerSerializer setAutherizationHeaderWithUsername:@"acooke+techtest@zendesk.com" password:@"mobile"];
    return headerSerializer.headers;
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
