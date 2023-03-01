//
//  StopDetailsTableViewController.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 13/05/21.
//

#import <UIKit/UIKit.h>
#import "Visit.h"
#import "Travel.h"

NS_ASSUME_NONNULL_BEGIN

@interface StopDetailsTableViewController : UITableViewController

@property (nonatomic, strong) Travel *theTravel;
@property (nonatomic, strong) Visit *theVisit;
@property (nonatomic, strong) NSDate *startTripDate;
@property (nonatomic, strong) NSDate *endTripDate;

@end

NS_ASSUME_NONNULL_END
