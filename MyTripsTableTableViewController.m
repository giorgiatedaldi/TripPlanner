//
//  MyTripsTableTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import "MyTripsTableTableViewController.h"
#import "TripList.h"
#import "MyTripDetailTableViewController.h"
#import "TripTableViewCell.h"
#import "NewTripTableViewController.h"
#import "DataSource.h"
#import "ManageNotifications.h"

@interface MyTripsTableTableViewController ()

@property (nonatomic, strong) TripList *tripsList;
@property (nonatomic, strong) ManageDates *toManageDates;
@property (nonatomic, strong) DataSource *ds;
@property (nonatomic, strong) ManageNotifications *toManageNotifications;

-(void) setUpData;

@end


@implementation MyTripsTableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Trips";
    self.tripsList = [[TripList alloc] init];
    self.toManageDates = [[ManageDates alloc] init];
    self.toManageNotifications = [[ManageNotifications alloc] init];
    [self.toManageNotifications requestAutohrization];
    [self setUpData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver: self selector:@selector(updateData) name:@"TripListChanged" object:nil];
    
}

-(void)updateData{
    [self.ds storeObject:self.tripsList];
    [self.toManageNotifications createLocalNotificationForTripList:self.tripsList];
}

-(void) setUpData {
    self.ds = [[DataSource alloc]init];
    [self.tripsList copyTripList:[self.ds loadObject]];
    
}
-(void) viewWillDisappear:(BOOL)animated {
    [self.ds storeObject:self.tripsList];
    [self.toManageNotifications createLocalNotificationForTripList:self.tripsList];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}



#pragma mark - Protocol sendNewTripDelegate

-(void) userDidEnterNewTrip:(Trip *)myTrip{
    [self.tripsList add:myTrip];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tripsList.size;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TripTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TripCell" forIndexPath:indexPath];
    Trip *t = [self.tripsList getAtIndex:indexPath.row];
    cell.tripTitle.text = t.name;
    NSString *end = [self.toManageDates dateToString:t.endDate withFormat:@"MMM dd"];
    NSString *start = [self.toManageDates dateToString:t.startDate withFormat:@"MMM dd"];
    cell.tripDate.text = [NSString stringWithFormat:@"%@ - %@", start, end];
    return cell;
}

-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (editingStyle) {
        [self.tripsList removeAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TripListChanged" object:nil];
        [self.tableView reloadData];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowTripDetail"]){
        if([segue.destinationViewController isKindOfClass:[MyTripDetailTableViewController class]]){
            MyTripDetailTableViewController *vc = (MyTripDetailTableViewController *)segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            Trip *t = [self.tripsList getAtIndex:indexPath.row];
            vc.theTrip = t;
        }
    }
    if([segue.identifier isEqualToString:@"ShowAddTrip"]){
        if([segue.destinationViewController isKindOfClass:[NewTripTableViewController class]]){
            NewTripTableViewController *vc = (NewTripTableViewController *)segue.destinationViewController;
            vc.delegate = self;
        }
    }
}

@end
