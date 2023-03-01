//
//  Visit.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import <Foundation/Foundation.h>
#import "Poi.h"

NS_ASSUME_NONNULL_BEGIN

@interface Visit : NSObject <NSCoding, NSSecureCoding>

- (instancetype)initWithLocation:(Poi *)location
                     arrivalDate:(NSDate *)arrivalDate
                   departureDate:(NSDate *)departureDate
                     placeOfStay:(NSString *)placeOfStay;

- (instancetype)initWithLocation:(Poi *)location
                     arrivalDate:(NSDate *)arrivalDate
                   departureDate:(NSDate *)departureDate;

@property (nonatomic, strong) Poi *location;
@property (nonatomic, strong) NSDate *arrivalDate;
@property (nonatomic, strong) NSDate *departureDate;
@property (nonatomic, strong) NSString *placeOfStay;

@end

NS_ASSUME_NONNULL_END
