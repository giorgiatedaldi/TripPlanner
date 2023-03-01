//
//  ManageNotifications.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 19/06/21.
//

#import <Foundation/Foundation.h>
#import "TripList.h"

NS_ASSUME_NONNULL_BEGIN

@interface ManageNotifications : NSObject
-(void)requestAutohrization;
-(void)createLocalNotificationForTripList:(TripList *)tripList;
@end

NS_ASSUME_NONNULL_END
