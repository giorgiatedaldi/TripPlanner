//
//  Stop.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import <Foundation/Foundation.h>
#import "Visit.h"
#import "Travel.h"
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stop : NSObject <MKAnnotation, NSCoding, NSSecureCoding>

- (instancetype)initWithMyTravel:(Travel *)myTravel
                         myVisit:(Visit *)myVisit;


@property (nonatomic, strong) Travel *myTravel;
@property (nonatomic, strong) Visit *myVisit;

@end

NS_ASSUME_NONNULL_END
