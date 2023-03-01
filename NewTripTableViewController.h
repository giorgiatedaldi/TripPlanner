//
//  NewTripTableViewController.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 16/05/21.
//

#import <UIKit/UIKit.h>
#import "StopList.h"
#import "AddStopTableViewController.h"
#import "MyStopsTableViewController.h"
#import "Trip.h"


NS_ASSUME_NONNULL_BEGIN

@protocol sendNewTripDelegate <NSObject>

-(void)userDidEnterNewTrip:(Trip *)myTrip;

@end

@interface NewTripTableViewController : UITableViewController <sendMyStopsDelegate>

@property (nonatomic, strong) StopList *theTripStopList;
@property (nonatomic, weak) id <sendNewTripDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
