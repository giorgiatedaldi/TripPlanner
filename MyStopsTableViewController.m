//
//  MyStopsTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 18/05/21.
//

#import "MyStopsTableViewController.h"
#import "StopList.h"
#import "ManageDates.h"
#import "StopDetailsTableViewController.h"

@interface MyStopsTableViewController ()

@property (nonatomic, strong) StopList *stopsList;
@property (nonatomic, strong) ManageDates *toManageDates;


-(void) userDidEnterNewStop:(Stop *)myStop;

@end

@implementation MyStopsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stopsList = [[StopList alloc] init];
    self.toManageDates = [[ManageDates alloc]init];
    [self.stopsList copyStopList:self.theStopsList];
}

-(void) userDidEnterNewStop:(Stop *)myStop {
    NSLog(@"data passed %@", myStop.myVisit.location);
    [self.stopsList add:myStop];
    [self.stopsList sortByArrivalDate];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [self.stopsList sortByArrivalDate];
    [self.tableView reloadData];
}

@synthesize delegate;
- (IBAction)backToNewTripSaving:(UIBarButtonItem *)sender {
    if (self.stopsList.size > 0) {
        [delegate userDidInsertStops:self.stopsList];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        NSLog(@"Error in passing stops list");
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [self.stopsList size];
            break;
        case 1:
            return 1;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StopCell" forIndexPath:indexPath];
        Stop *s = [self.stopsList getAtIndex:indexPath.row];
        NSString *arrivalDate = [self.toManageDates dateToString:s.myVisit.arrivalDate withFormat:@"EEEE, dd MMMM YYYY"];
        cell.textLabel.text = s.myVisit.location.name;
        cell.detailTextLabel.text = arrivalDate;
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddStopCell" forIndexPath:indexPath];
        return cell;
    }
   
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section){
        case 0: return @" ";;
        default: return @" ";
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.stopsList removeAtIndex:indexPath.row];
        [self.theStopsList removeAtIndex:indexPath.row];
        [self.tableView reloadData];

    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"NewStop"]){
        if([segue.destinationViewController isKindOfClass:[AddStopTableViewController class]]){
            AddStopTableViewController *vc = (AddStopTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.startTripDate = self.startTripDate;
            vc.endTripDate = self.endTripDate;
        }
    }
    if([segue.identifier isEqualToString:@"ShowStopDetail"]){
        if([segue.destinationViewController isKindOfClass:[StopDetailsTableViewController class]]){
            StopDetailsTableViewController *vc = (StopDetailsTableViewController *)segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            Stop *s = [self.stopsList getAtIndex:indexPath.row];
            vc.theTravel = s.myTravel;
            vc.theVisit = s.myVisit;
            
        }
    }
}

@end
