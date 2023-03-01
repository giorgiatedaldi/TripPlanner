//
//  NewTripTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 16/05/21.
//

#import "NewTripTableViewController.h"
#import "AddStopTableViewController.h"
#import "StopList.h"
#import "ManageDates.h"
#import "ManageTextField.h"

@interface NewTripTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *startDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endDatePicker;
@property (weak, nonatomic) IBOutlet UIButton *addStopsButton;
@property (nonatomic, strong) StopList *stopList;
@property (nonatomic, strong) ManageDates *toManageDates;
@property (nonatomic, strong) ManageTextField *toCheckTextField;



- (void)checkEmptyTextField:(UITextField *)sender;
- (BOOL)checkDates;
- (void) userDidInsertStops:(StopList *)myStops;
- (Trip *)createTheNewTrip;


@end

@implementation NewTripTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.addStopsButton.layer setCornerRadius:10];
    self.stopList = [[StopList alloc] init];
    self.toManageDates = [[ManageDates alloc] init];
    self.toCheckTextField = [[ManageTextField alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyStopTableViewCell" bundle:nil]
       forCellReuseIdentifier:@"MyStopCell"];

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
- (IBAction)pressedReturnonKeyBoard:(id)sender {
}


- (IBAction)addStopPressed:(UIButton *)sender {
       if ([self.toCheckTextField textFieldIsOk:self.nameTextField.text] && [self.toCheckTextField textFieldIsOk:self.descriptionTextField.text] && [self checkDates]) {
        [self performSegueWithIdentifier:@"ShowMyStops" sender:self];
    }
    else {
        [self checkEmptyTextField:self.nameTextField];
        [self checkEmptyTextField:self.descriptionTextField];
        NSLog(@"Should not perform segue");
    }
    
}

-(void) userDidInsertStops:(StopList *)myStops {
    self.theTripStopList = myStops;
}

-(Trip *)createTheNewTrip {
    if ([self.toCheckTextField textFieldIsOk:self.nameTextField.text] && [self.toCheckTextField textFieldIsOk:self.descriptionTextField.text] && [self checkDates] && [self.theTripStopList size]>0) {
        Trip *t = [[Trip alloc] initWithName:self.nameTextField.text
                             tripDescription:self.descriptionTextField.text
                                   startDate:[self.startDatePicker date]
                                     endDate:[self.endDatePicker date]
                                     myStops:self.theTripStopList];
        return t;
    }
    else {
        return nil;
    }
}

@synthesize delegate;
- (IBAction)backToMyTripsSaving:(UIBarButtonItem *)sender {
    if ([self.theTripStopList size] > 0){
        if ([self createTheNewTrip]) {
            [delegate userDidEnterNewTrip:[self createTheNewTrip]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"TripListChanged" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        NSLog(@"Invalid data");
        [self checkEmptyTextField:self.nameTextField];
        [self checkEmptyTextField:self.descriptionTextField];
    }
    
}


#pragma mark - Table view data source


/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}*/



/*- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyStopCell" forIndexPath:indexPath];
    if (indexPath.section != 3) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else {
        MyStopTableViewCell *cell;
            cell = [tableView dequeueReusableCellWithIdentifier:@"MyStopCell" forIndexPath:indexPath];
        return cell;
            
    }
} */


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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowMyStops"]){
        if([segue.destinationViewController isKindOfClass:[MyStopsTableViewController class]]){
            MyStopsTableViewController *vc = (MyStopsTableViewController *)segue.destinationViewController;
            vc.delegate = self;
            vc.theStopsList = self.theTripStopList;
            vc.startTripDate = [self.startDatePicker date];
            vc.endTripDate = [self.endDatePicker date];
        }
    }
}


@end
