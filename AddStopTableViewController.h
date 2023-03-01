//
//  AddStopTableViewController.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 17/05/21.
//

#import <UIKit/UIKit.h>
#import "Stop.h"
#import "SearchPlaceTableViewController.h"
NS_ASSUME_NONNULL_BEGIN

@protocol sendDataDelegate <NSObject>

-(void)userDidEnterNewStop:(Stop *)myStop;

@end

@interface AddStopTableViewController : UITableViewController <UITextFieldDelegate, sendPlaceDelegate>

@property (nonatomic, strong) Stop *theStop;
@property (nonatomic, strong) NSDate *startTripDate;
@property (nonatomic, strong) NSDate *endTripDate;
@property (nonatomic, weak) id <sendDataDelegate> delegate;
@property (nonatomic, strong) Poi *departurePoi;
@property (nonatomic, strong) Poi *arrivalPoi;
@property (nonatomic, strong) Poi *locationPoi;


@end

NS_ASSUME_NONNULL_END
