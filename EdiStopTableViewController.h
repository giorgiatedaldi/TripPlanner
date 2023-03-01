//
//  EdiStopTableViewController.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 16/06/21.
//

#import <UIKit/UIKit.h>
#import "Stop.h"
#import "SearchPlaceTableViewController.h"


NS_ASSUME_NONNULL_BEGIN

@interface EdiStopTableViewController : UITableViewController <UITextFieldDelegate, sendPlaceDelegate>

@property (nonatomic, strong) Travel *theTravel;
@property (nonatomic, strong) Visit *theVisit;
@property (nonatomic, strong) NSDate *startTripDate;
@property (nonatomic, strong) NSDate *endTripDate;

@end

NS_ASSUME_NONNULL_END
