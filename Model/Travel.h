//
//  Travel.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import <Foundation/Foundation.h>
#import "Poi.h"

NS_ASSUME_NONNULL_BEGIN

@interface Travel : NSObject <NSCoding, NSSecureCoding>

- (instancetype)initWithDepartureLocation:(Poi *)departureLocation
                          arrivalLocation:(Poi *)arrivalLocation
                              arrivalDate:(NSDate *)arrivalDate
                           transportation:(NSString *)transportation;

- (instancetype)initWithDepartureLocation:(Poi *)departureLocation
                          arrivalLocation:(Poi *)arrivalLocation
                              arrivalDate:(NSDate *)arrivalDate;

@property (nonatomic, strong) Poi *departureLocation;
@property (nonatomic, strong) Poi *arrivalLocation;
@property (nonatomic, strong) NSDate *arrivalDate;
@property (nonatomic, strong) NSString *transportation;



@end

NS_ASSUME_NONNULL_END
