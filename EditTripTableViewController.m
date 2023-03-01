//
//  EditTripTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 10/06/21.
//

#import "EditTripTableViewController.h"
#import "ManageDates.h"
#import "ManageTextField.h"

@interface EditTripTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (nonatomic, strong) ManageDates *toManageDates;
@property (nonatomic, strong) ManageTextField *toCheckTextField;

- (void)checkEmptyTextField:(UITextField *)sender;
- (BOOL)checkDates;
- (BOOL)editTripSuccessfully;


@end

@implementation EditTripTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setModalInPresentation:YES];
    self.toManageDates = [[ManageDates alloc] init];
    self.toCheckTextField = [[ManageTextField alloc] init];
    self.titleTextField.text = self.theTrip.name;
    self.descriptionTextField.text = self.theTrip.tripDescription;
    [self.startDatePicker setDate:self.theTrip.startDate];
    [self.endDatePicker setDate:self.theTrip.endDate];
}

- (void)checkEmptyTextField:(UITextField *)sender {
    if (![self.toCheckTextField textFieldIsOk:sender.text]) {
        [sender.layer setBorderColor:[[UIColor redColor] CGColor]];
        [sender.layer setBorderWidth:1.0];
        [sender.layer setCornerRadius:5];
    }
    else {
        [sender.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
}

- (IBAction)updateTextField:(UITextField *)sender {
    if ([self.toCheckTextField textFieldIsOk:sender.text]) {
        [sender.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
}

-(BOOL)checkDates{
    NSDate *displayedStart = [self.startDatePicker date];
    NSDate *displayedEnd = [self.endDatePicker date];
    if ([self.toManageDates startDate:displayedStart isBeforeEndDate:displayedEnd] || [self.toManageDates startDate:displayedStart isEqualToEndDate:displayedEnd]) {
        return true;
    }
    else {
        return false;
    }
}

- (IBAction)startDateChanged:(UIDatePicker *)sender {
    NSDate *displayedStart = [self.startDatePicker date];
    NSDate *displayedEnd = [self.endDatePicker date];
    if([self.toManageDates startDate:displayedStart isLaterThanEndDate:displayedEnd] || [self.toManageDates startDate:displayedStart isEqualToEndDate:displayedEnd]) {
        [self.endDatePicker setDate:displayedStart];
        [self.endDatePicker.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
    else if ([self.toManageDates startDate:displayedStart isBeforeEndDate:displayedEnd]) {
        [self.endDatePicker.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
}

- (IBAction)pressedReturnonKeyBoard:(id)sender {
}

- (IBAction)endDateChanged:(UIDatePicker *)sender {
    NSDate *displayedStart = [self.startDatePicker date];
    NSDate *displayedEnd = [self.endDatePicker date];
    if([self.toManageDates startDate:displayedStart isBeforeEndDate:displayedEnd] || [self.toManageDates startDate:displayedStart isEqualToEndDate:displayedEnd]) {
        [self.endDatePicker.layer setBorderColor:[[UIColor clearColor] CGColor]];
    }
    else {
        [self.endDatePicker.layer setBorderColor:[[UIColor redColor] CGColor]];
        [self.endDatePicker.layer setBorderWidth:1.0];
        [self.endDatePicker.layer setCornerRadius:5];
    }
}

- (BOOL)editTripSuccessfully {
    if ([self.toCheckTextField textFieldIsOk:self.titleTextField.text] && [self.toCheckTextField textFieldIsOk:self.descriptionTextField.text] && [self checkDates]){
        [self.theTrip setName:self.titleTextField.text];
        [self.theTrip setTripDescription:self.descriptionTextField.text];
        [self.theTrip setStartDate:[self.startDatePicker date]];
        [self.theTrip setEndDate:[self.endDatePicker date]];
        return true;
    }
    else {
        return false;
    }
}

- (IBAction)backToMyTripDetail:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@synthesize delegate;

- (IBAction)editTrip:(UIBarButtonItem*)sender {
    if ([self editTripSuccessfully]) {
        [delegate userDidEditTheTrip:self.theTrip];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TripListChanged" object:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else {
        NSLog(@"Invalid data");
        [self checkEmptyTextField:self.titleTextField];
        [self checkEmptyTextField:self.descriptionTextField];
    }
    
}



#pragma mark - Table view data source



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
