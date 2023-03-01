//
//  AddStopTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 17/05/21.
//

#import "AddStopTableViewController.h"
#import "ManageTextField.h"
#import "ManageDates.h"
#import "SearchPlaceTableViewController.h"

@interface AddStopTableViewController ()

@property (weak, nonatomic) IBOutlet UITextField *departureTextField;
@property (weak, nonatomic) IBOutlet UITextField *arrivalTextField;
@property (weak, nonatomic) IBOutlet UITextField *transportTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *placeOfStayTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *travelDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *visitDepartureDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *visitArrivalDate;
@property (nonatomic, strong) ManageTextField *toCheckTextField;
@property (nonatomic, strong) ManageDates *toMangeDates;


- (Travel *)createTheTravel;
- (Visit *)createTheVisit;
- (Stop *)createTheStop;
- (BOOL)checkDates;
- (void) userDidSelectPlace:(Poi *)mapItem forTextField:(id)sender;

@end

@implementation AddStopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setModalInPresentation:true];
    self.departureTextField.delegate = self;
    self.arrivalTextField.delegate = self;
    self.locationTextField.delegate = self;
    self.toCheckTextField = [[ManageTextField alloc] init];
    self.toMangeDates = [[ManageDates alloc] init];
    [self.travelDate setMinimumDate:self.startTripDate];
    [self.travelDate setMaximumDate:self.endTripDate];
    [self.visitArrivalDate setMinimumDate:self.startTripDate];
    [self.visitArrivalDate setMaximumDate:self.endTripDate];
    [self.visitDepartureDate setMinimumDate:self.startTripDate];
    [self.visitDepartureDate setMaximumDate:self.endTripDate];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range       replacementString:(NSString *)string{
    return NO;
}

- (Travel *)createTheTravel {
    if([self.toCheckTextField textFieldIsOk:self.transportTextField.text]) {
        Travel *t = [[Travel alloc] initWithDepartureLocation:self.departurePoi
                                              arrivalLocation:self.arrivalPoi
                                                  arrivalDate:[self.travelDate date]
                                               transportation:self.transportTextField.text];
        return t;
    }
    else {
        Travel *t = [[Travel alloc] initWithDepartureLocation:self.departurePoi
                                              arrivalLocation:self.arrivalPoi
                                                  arrivalDate:[self.travelDate date]];
        return t;
    }
}

- (Visit *)createTheVisit {
    if ([self.toCheckTextField textFieldIsOk:self.placeOfStayTextField.text]){
        Visit *v = [[Visit alloc] initWithLocation:self.locationPoi
                                       arrivalDate:[self.visitArrivalDate date]
                                     departureDate:[self.visitDepartureDate date]
                                       placeOfStay:self.placeOfStayTextField.text];
        return v;
    }
    else {
        Visit *v = [[Visit alloc] initWithLocation:self.locationPoi
                                       arrivalDate:[self.visitArrivalDate date]
                                     departureDate:[self.visitDepartureDate date]];
        return v;
    }
}

- (Stop *)createTheStop {
    Travel *t = [self createTheTravel];
    Visit *v = [self createTheVisit];
    Stop *s = [[Stop alloc] initWithMyTravel:t
                                     myVisit:v];
    return s;
}

- (BOOL)checkDates {
    NSDate *displayedArrival = [self.visitArrivalDate date];
    NSDate *displayedDeparture = [self.visitDepartureDate date];
    if ([self.toMangeDates startDate:displayedArrival isBeforeEndDate:displayedDeparture] || [self.toMangeDates startDate:displayedArrival isEqualToEndDate:displayedDeparture] ) {
        return true;
    }
    else {
        return false;
    }
}

@synthesize delegate;
- (IBAction)saveStop:(id)sender {
    if ([self.toCheckTextField textFieldIsOk:self.departureTextField.text] && [self.toCheckTextField textFieldIsOk:self.arrivalTextField.text] && [self.toCheckTextField textFieldIsOk:self.locationTextField.text] && [self checkDates]) {
        [delegate userDidEnterNewStop:[self createTheStop]];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        [self checkTextFields:self.departureTextField];
        [self checkTextFields:self.arrivalTextField];
        [self checkTextFields:self.locationTextField];
    }
}


- (IBAction)travelDateChanged:(UIDatePicker *)sender {
    [self.visitArrivalDate setDate:[self.travelDate date]];
    [self arrivalDateChanged:self.visitArrivalDate];
}

- (IBAction)arrivalDateChanged:(UIDatePicker *)sender {
    NSDate *displayedArrival = [self.visitArrivalDate date];
    NSDate *displayedDeparture = [self.visitDepartureDate date];
    
    [self.travelDate setDate:displayedArrival];
    
    
    if([self.toMangeDates startDate:displayedArrival isLaterThanEndDate:displayedDeparture] || [self.toMangeDates startDate:displayedArrival isEqualToEndDate:displayedDeparture]) {
        [self.visitDepartureDate setDate:displayedArrival];
        [self.visitDepartureDate.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
    else if ([self.toMangeDates startDate:displayedArrival isBeforeEndDate:displayedDeparture]) {
        [self.visitDepartureDate.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
    
}

- (IBAction)visitDepartureDate:(UIDatePicker *)sender {
    NSDate *displayedArrival = [self.visitArrivalDate date];
    NSDate *displayedDeparture = [self.visitDepartureDate date];
    if([self.toMangeDates startDate:displayedArrival isBeforeEndDate:displayedDeparture] || [self.toMangeDates startDate:displayedArrival isEqualToEndDate:displayedDeparture]) {
        [self.visitDepartureDate.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
    else {
        [self.visitDepartureDate.layer setBorderColor:[[UIColor redColor] CGColor]];
        [self.visitDepartureDate.layer setBorderWidth:1.0];
        [self.visitDepartureDate.layer setCornerRadius:5];
    }
}

- (IBAction)searchForPlaces:(UITextField *)sender {
    if (sender == self.departureTextField) {
        [self performSegueWithIdentifier:@"SearchPlacesFromDeparture" sender:self];
    }
    else if (sender == self.arrivalTextField) {
        [self performSegueWithIdentifier:@"SearchPlacesFromArrival" sender:self];
    }
    if (sender == self.locationTextField) {
        [self performSegueWithIdentifier:@"SearchPlacesFromLocation" sender:self];
    }
}

- (IBAction)checkTextFields:(UITextField *)sender {
    if (![self.toCheckTextField textFieldIsOk:sender.text]) {
        [sender.layer setBorderColor:[[UIColor redColor] CGColor]];
        [sender.layer setBorderWidth:1.0];
        [sender.layer setCornerRadius:5];
    }
    else {
        [sender.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
}

- (IBAction)returnPressedOnKeyBoard:(UITextField *)sender {
}

-(void) userDidSelectPlace:(Poi *)mapItem forTextField:(id)sender {
    NSLog(@"Name: %@, lat: %f, long: %f", mapItem.name, mapItem.latitude, mapItem.longitude);
    if (sender == self.departureTextField) {
        self.departureTextField.text = mapItem.name;
        self.departurePoi = [[Poi alloc] initWithName:mapItem.name latitdue:mapItem.latitude longitude:mapItem.longitude];
        [self checkTextFields:self.departureTextField];
    }
    else if (sender == self.arrivalTextField){
        self.arrivalTextField.text = mapItem.name;
        self.arrivalPoi = [[Poi alloc] initWithName:mapItem.name latitdue:mapItem.latitude longitude:mapItem.longitude];
        [self checkTextFields:self.arrivalTextField];
    }
    else if (sender == self.locationTextField){
        self.locationTextField.text = mapItem.name;
        self.locationPoi = [[Poi alloc] initWithName:mapItem.name latitdue:mapItem.latitude longitude:mapItem.longitude];
        [self checkTextFields:self.locationTextField];
    }
    else {
        NSLog(@"Error with sender");
    }
    [self.tableView reloadData];
}

- (IBAction)backToMyStopsWithoutSaving:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 9;
            break;
        case 1:
            return 7;
            break;
        default: return 0;
            break;
    }
    
}*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"SearchPlacesFromDeparture"]){
        if([segue.destinationViewController isKindOfClass:[SearchPlaceTableViewController class]]){
            SearchPlaceTableViewController *vc = (SearchPlaceTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.theSender = self.departureTextField;
        }
    }
    if([segue.identifier isEqualToString:@"SearchPlacesFromArrival"]){
        if([segue.destinationViewController isKindOfClass:[SearchPlaceTableViewController class]]){
            SearchPlaceTableViewController *vc = (SearchPlaceTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.theSender = self.arrivalTextField;
        }
    }
    if([segue.identifier isEqualToString:@"SearchPlacesFromLocation"]){
        if([segue.destinationViewController isKindOfClass:[SearchPlaceTableViewController class]]){
            SearchPlaceTableViewController *vc = (SearchPlaceTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.theSender = self.locationTextField;
        }
    }
}

@end
