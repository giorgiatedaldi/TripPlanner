//
//  EditTripTableViewController.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 10/06/21.
//

#import <UIKit/UIKit.h>
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@protocol sendEditTripDelegate <NSObject>

-(void)userDidEditTheTrip:(Trip *)editTrip;

@end

@interface EditTripTableViewController : UITableViewController

@property (nonatomic, strong) Trip *theTrip;
@property (nonatomic, weak) id <sendEditTripDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
