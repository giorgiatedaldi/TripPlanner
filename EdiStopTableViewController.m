//
//  EdiStopTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 16/06/21.
//

#import "EdiStopTableViewController.h"
#import "ManageDates.h"
#import "ManageTextField.h"

@interface EdiStopTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *visitArrivalDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *visitDepartureDate;
@property (weak, nonatomic) IBOutlet UITextField *departureLocation;
@property (weak, nonatomic) IBOutlet UITextField *arrivalLocation;
@property (weak, nonatomic) IBOutlet UIDatePicker *travelDate;
@property (weak, nonatomic) IBOutlet UITextField *transportTextField;
@property (weak, nonatomic) IBOutlet UITextField *placeOfStayTextField;
@property (nonatomic, strong) ManageTextField *toCheckTextField;
@property (nonatomic, strong) ManageDates *toMangeDates;


- (BOOL)checkDates;
- (void) userDidSelectPlace:(Poi *)mapItem forTextField:(id)sender;

@end

@implementation EdiStopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.departureLocation.delegate = self;
    self.arrivalLocation.delegate = self;
    self.locationTextField.delegate = self;
    [self.travelDate setMinimumDate:self.startTripDate];
    [self.travelDate setMaximumDate:self.endTripDate];
    [self.visitArrivalDate setMinimumDate:self.startTripDate];
    [self.visitArrivalDate setMaximumDate:self.endTripDate];
    [self.visitDepartureDate setMinimumDate:self.startTripDate];
    [self.visitDepartureDate setMaximumDate:self.endTripDate];
    
    self.locationTextField.text = self.theVisit.location.name;
    [self.visitArrivalDate setDate:self.theVisit.arrivalDate];
    [self.visitDepartureDate setDate:self.theVisit.departureDate];
    self.placeOfStayTextField.text = self.theVisit.placeOfStay;
    self.departureLocation.text = self.theTravel.departureLocation.name;
    self.arrivalLocation.text = self.theTravel.arrivalLocation.name;
    self.transportTextField.text = self.theTravel.transportation;
    [self.travelDate setDate:self.theTravel.arrivalDate];
    self.toCheckTextField = [[ManageTextField alloc] init];
    self.toMangeDates = [[ManageDates alloc] init];
    
    
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range       replacementString:(NSString *)string{
    return NO;
}

- (IBAction)returnPressedOnKeyBoard:(UITextField *)sender {
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

- (IBAction)searchForPlaces:(UITextField *)sender {
    if (sender == self.departureLocation) {
        [self performSegueWithIdentifier:@"SearchToEditDeparture" sender:self];
    }
    else if (sender == self.arrivalLocation) {
        [self performSegueWithIdentifier:@"SearchToEditArrival" sender:self];
    }
    if (sender == self.locationTextField) {
        [self performSegueWithIdentifier:@"SearchToEditLocation" sender:self];
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

- (IBAction)travelDateChanged:(UIDatePicker *)sender {
    [self.visitArrivalDate setDate:[self.travelDate date]];
    [self arrivalDateChanged:self.visitArrivalDate];
}

- (IBAction)saveEditStop:(id)sender {
    if ([self editStopSuccessfully]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TripListChanged" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(BOOL)editStopSuccessfully{
    if ([self.toCheckTextField textFieldIsOk:self.departureLocation.text] && [self.toCheckTextField textFieldIsOk:self.arrivalLocation.text] && [self.toCheckTextField textFieldIsOk:self.locationTextField.text] && [self checkDates]) {
        [self.theVisit setArrivalDate:[self.visitArrivalDate date]];
        [self.theVisit setDepartureDate:[self.visitDepartureDate date]];
        [self.theVisit setPlaceOfStay:self.placeOfStayTextField.text];
        [self.theTravel setArrivalDate:[self.travelDate date]];
        [self.theTravel setTransportation:self.transportTextField.text];
        return true;
        
    }
    else {
        [self checkTextFields:self.departureLocation];
        [self checkTextFields:self.arrivalLocation];
        [self checkTextFields:self.locationTextField];
        return false;
    }
    
    
}

-(void) userDidSelectPlace:(Poi *)mapItem forTextField:(id)sender {
    NSLog(@"Name: %@, lat: %f, long: %f", mapItem.name, mapItem.latitude, mapItem.longitude);
    if (sender == self.departureLocation) {
        self.departureLocation.text = mapItem.name;
        [self.theTravel setDepartureLocation:mapItem];
        [self checkTextFields:self.departureLocation];
    }
    else if (sender == self.arrivalLocation){
        self.arrivalLocation.text = mapItem.name;
        //self.arrivalPoi = [[Poi alloc] initWithName:mapItem.name latitdue:mapItem.latitude longitude:mapItem.longitude];
        [self.theTravel setArrivalLocation:mapItem];
        [self checkTextFields:self.arrivalLocation];
    }
    else if (sender == self.locationTextField){
        self.locationTextField.text = mapItem.name;
        [self.theVisit setLocation:mapItem];
        //self.locationPoi = [[Poi alloc] initWithName:mapItem.name latitdue:mapItem.latitude longitude:mapItem.longitude];
        [self checkTextFields:self.locationTextField];
    }
    else {
        NSLog(@"Error with sender");
    }
    [self.tableView reloadData];
}

- (IBAction)backToStopDetailsWithoutSaving:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"SearchToEditDeparture"]){
        if([segue.destinationViewController isKindOfClass:[SearchPlaceTableViewController class]]){
            SearchPlaceTableViewController *vc = (SearchPlaceTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.theSender = self.departureLocation;
        }
    }
    if([segue.identifier isEqualToString:@"SearchToEditArrival"]){
        if([segue.destinationViewController isKindOfClass:[SearchPlaceTableViewController class]]){
            SearchPlaceTableViewController *vc = (SearchPlaceTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.theSender = self.arrivalLocation;
        }
    }
    if([segue.identifier isEqualToString:@"SearchToEditLocation"]){
        if([segue.destinationViewController isKindOfClass:[SearchPlaceTableViewController class]]){
            SearchPlaceTableViewController *vc = (SearchPlaceTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.theSender = self.locationTextField;
        }
    }
}


@end
