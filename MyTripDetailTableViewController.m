//
//  MyTripDetailTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import "MyTripDetailTableViewController.h"
#import "StopDetailsTableViewController.h"
#import "EditTripTableViewController.h"
#import "DurationTableViewCell.h"
#import "DescriptionTableViewCell.h"
#import "MapViewController.h"
#import "ManageDates.h"

@interface MyTripDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tripName;
@property (nonatomic, strong) ManageDates *toManageDates;

@end

@implementation MyTripDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"DurationTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"DurationCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DescriptionTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"DescriptionCell"];
    self.tripName.text = self.theTrip.name;
    self.toManageDates = [[ManageDates alloc] init];

}

-(void)viewWillAppear:(BOOL)animated{
    [self.theTrip.myStops sortByArrivalDate];
    [self.tableView reloadData];
}

#pragma mark - Protocol sendDataDelegate

-(void) userDidEnterNewStop:(Stop *)myStop {
    NSLog(@"data passed %@", myStop.myVisit.location);
    [self.theTrip.myStops add:myStop];
    [self.theTrip.myStops sortByArrivalDate];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TripListChanged" object:nil];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch(section){
        case 0: return 1;
        case 1: return 2;
        case 2: return self.theTrip.myStops.size;
        case 3: return 1;
        default: return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section){
        case 0: return @"Description";
        case 1: return @"Duration";
        case 2: return @"My stops";
        default: return nil;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *end = [self.toManageDates dateToString:self.theTrip.endDate withFormat:@"EE, dd MMMM YYYY"];
    NSString *start = [self.toManageDates dateToString:self.theTrip.startDate withFormat:@"EE, dd MMMM YYYY"];
    
    if (indexPath.section == 0) {
        DescriptionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DescriptionCell" forIndexPath:indexPath];
        cell.textDescription.text = self.theTrip.tripDescription;
        return cell;
    }
    else if (indexPath.section == 1) {
        DurationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DurationCell" forIndexPath:indexPath];
        [cell setUserInteractionEnabled:NO];
        switch (indexPath.row) {
            case 0:
                cell.fromOrToLabel.text = @"From";
                cell.dateLabel.text = start;
                break;
            case 1:
                cell.fromOrToLabel.text = @"To";
                cell.dateLabel.text = end;
                break;
        }
        return cell;
    }
    else if (indexPath.section == 3) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddStopButtonCell" forIndexPath:indexPath];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StopCell" forIndexPath:indexPath];
        Stop *s = [self.theTrip.myStops getAtIndex:indexPath.row];
        NSString *visitArrivalDate = [self.toManageDates dateToString:s.myVisit.arrivalDate withFormat:@"EEEE, dd MMMM YYYY"];

        cell.textLabel.text = [NSString stringWithFormat:@"%@", s.myVisit.location.name];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", visitArrivalDate];
        return cell;
    }
}



-(BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.theTrip.myStops.size > 1) {
        return YES;
    }
    else {
        return NO;
    }
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (editingStyle && self.theTrip.myStops.size > 1) {
        [self.theTrip.myStops removeAtIndex:indexPath.row];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TripListChanged" object:nil];
        [self.tableView reloadData];
    }
}

#pragma mark - Protocol sendEditTripDelegate

-(void)userDidEditTheTrip:(Trip *)editTrip{
    [self.theTrip setName:editTrip.name];
    [self.theTrip setTripDescription:editTrip.tripDescription];
    [self.theTrip setStartDate:editTrip.startDate];
    [self.theTrip setEndDate:editTrip.endDate];
    self.tripName.text = self.theTrip.name;
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowStopDetails"]){
        if([segue.destinationViewController isKindOfClass:[StopDetailsTableViewController class]]){
            StopDetailsTableViewController *vc = (StopDetailsTableViewController *)segue.destinationViewController;
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            Stop *s = [self.theTrip.myStops getAtIndex:indexPath.row];
            vc.theTravel = s.myTravel;
            vc.theVisit = s.myVisit;
            vc.endTripDate = self.theTrip.endDate;
            vc.startTripDate = self.theTrip.startDate;
        }
    }
    if([segue.identifier isEqualToString:@"ShowMap"]){
        if([segue.destinationViewController isKindOfClass:[MapViewController class]]){
            MapViewController *vc = (MapViewController *)segue.destinationViewController;
            NSMutableArray *mArray = [[NSMutableArray alloc] init];
            [[self.theTrip.myStops getAll] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[Stop class]]) {
                    [mArray addObject:obj];
                }
            }];
            vc.stops = mArray;
        }
    }
    if([segue.identifier isEqualToString:@"EditTrip"]){
        if([segue.destinationViewController isKindOfClass:[EditTripTableViewController class]]){
            EditTripTableViewController *vc = (EditTripTableViewController *)segue.destinationViewController;
            vc.theTrip = self.theTrip;
            vc.delegate = self;
        }
    }
    if([segue.identifier isEqualToString:@"ShowAddStop"]){
        if([segue.destinationViewController isKindOfClass:[AddStopTableViewController class]]){
            AddStopTableViewController *vc = (AddStopTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.startTripDate = self.theTrip.startDate;
            vc.endTripDate = self.theTrip.endDate;
        }
    }
}

@end
