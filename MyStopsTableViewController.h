//
//  MyStopsTableViewController.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 18/05/21.
//

#import <UIKit/UIKit.h>
#import "AddStopTableViewController.h"
#import "StopList.h"
NS_ASSUME_NONNULL_BEGIN

@protocol sendMyStopsDelegate <NSObject>

-(void)userDidInsertStops:(StopList *)myStops;

@end


@interface MyStopsTableViewController : UITableViewController <sendDataDelegate>

@property (nonatomic, weak) id <sendMyStopsDelegate> delegate;
@property (nonatomic, strong) StopList *theStopsList;
@property (nonatomic, strong) NSDate *startTripDate;
@property (nonatomic, strong) NSDate *endTripDate;



@end

NS_ASSUME_NONNULL_END
