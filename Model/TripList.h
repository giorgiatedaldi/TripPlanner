//
//  TripList.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import <Foundation/Foundation.h>
#import "Trip.h"

NS_ASSUME_NONNULL_BEGIN

@interface TripList : NSObject

- (long)size;
- (NSArray *)getAll;
- (void)add:(Trip *)t;
- (Trip *)getAtIndex:(NSInteger)index;
- (void)removeAtIndex:(NSInteger)index;
- (void) copyTripList:(TripList *)toCopy ;

@end

NS_ASSUME_NONNULL_END
