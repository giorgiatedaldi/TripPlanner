//
//  StopDetailsTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 13/05/21.
//

#import "StopDetailsTableViewController.h"
#import "TravelDetailTableViewCell.h"
#import "IconAndLabelTableViewCell.h"
#import "VisitDateTableViewCell.h"
#import "VisitLocationTableViewCell.h"
#import "EdiStopTableViewController.h"
#import "TravelDateTableViewCell.h"
#import "ManageDates.h"

@interface StopDetailsTableViewController ()

@property (nonatomic, strong) ManageDates *toManageDates;


@end

@implementation StopDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.toManageDates = [[ManageDates alloc] init];
    self.title = self.theVisit.location.name;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TravelDetailTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"TravelCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"IconAndLabelTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"IconLabelCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VisitDateTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"VisitDateCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VisitLocationTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"VisitLocationCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TravelDateTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"TravelDateCell"];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch(section){
        case 0: return @"Visit details";
        case 1: return @"Travel details";
        default: return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            if ([self.theVisit.placeOfStay  isEqualToString:@""]) {
                return 2;
            }
            else {
                return 3;
            }
        case 1:
            if ([self.theTravel.transportation isEqualToString:@""]) {
                return 2;
            }
            else {
                return 3;
            }
            break;
        default: return 0;
            break;
    };
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *travelDate = [self.toManageDates dateToString:self.theTravel.arrivalDate withFormat:@"EEEE, dd MMMM YYYY"];
    NSString *arrivalDate = [self.toManageDates dateToString:self.theVisit.arrivalDate withFormat:@"EEEE, dd MMMM YYYY"];
    NSString *departureDate = [self.toManageDates dateToString:self.theVisit.departureDate withFormat:@"EEEE, dd MMMM YYYY"];
    if (indexPath.section == 0 && indexPath.row == 0) {
        VisitLocationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitLocationCell" forIndexPath:indexPath];
        cell.visitiLocation.text = self.theVisit.location.name;
        return cell;
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        VisitDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VisitDateCell" forIndexPath:indexPath];
        cell.arriveDate.text = arrivalDate;
        cell.departureDate.text = departureDate;
        return cell;
    }
    else if (indexPath.section == 0 && indexPath.row == 2) {
        IconAndLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconLabelCell" forIndexPath:indexPath];
        UIImage *icon = [UIImage systemImageNamed:@"house.fill"];
        cell.icon.image = icon;
        cell.label.text = self.theVisit.placeOfStay;
        return cell;
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        TravelDateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TravelDateCell" forIndexPath:indexPath];
        cell.travelDate.text = travelDate;
        return cell;
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        TravelDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TravelCell" forIndexPath:indexPath];
        cell.arrivalLocation.text = self.theTravel.arrivalLocation.name;
        cell.departureLocation.text = self.theTravel.departureLocation.name;
        return cell;
    }
    else if (indexPath.section == 1 && indexPath.row == 2) {
        IconAndLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconLabelCell" forIndexPath:indexPath];
        UIImage *icon = [UIImage systemImageNamed:@"tram.fill"];
        cell.icon.image = icon;
        cell.label.text = self.theTravel.transportation;
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StopDetail" forIndexPath:indexPath];
        return cell;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowEditStop"]){
        if([segue.destinationViewController isKindOfClass:[EdiStopTableViewController class]]){
            EdiStopTableViewController *vc = (EdiStopTableViewController *)segue.destinationViewController;
            vc.theTravel = self.theTravel;
            vc.theVisit = self.theVisit;
            vc.endTripDate = self.endTripDate;
            vc.startTripDate = self.startTripDate;
        }
    }
}


@end
