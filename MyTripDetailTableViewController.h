//
//  MyTripDetailTableViewController.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"
#include "EditTripTableViewController.h"
#import "AddStopTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyTripDetailTableViewController : UITableViewController <sendEditTripDelegate, sendDataDelegate>

@property (nonatomic, strong) Trip *theTrip;

@end

NS_ASSUME_NONNULL_END
