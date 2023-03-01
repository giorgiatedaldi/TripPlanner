//
//  DataSource.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 11/06/21.
//

#import <Foundation/Foundation.h>
#include "TripList.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataSource : NSObject

- (void)storeObject:(TripList *)tripList;
- (TripList*)loadObject;

@end

NS_ASSUME_NONNULL_END
