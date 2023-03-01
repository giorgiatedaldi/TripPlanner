//
//  Trip.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import <Foundation/Foundation.h>
#import "StopList.h"

NS_ASSUME_NONNULL_BEGIN

@interface Trip : NSObject <NSCoding, NSSecureCoding>

- (instancetype)initWithName:(NSString *)name
             tripDescription:(NSString *)tripDescription
                   startDate:(NSDate *)startDate
                     endDate:(NSDate *)endDate
                     myStops:(StopList *)myStops;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tripDescription;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) StopList *myStops;


@end

NS_ASSUME_NONNULL_END
