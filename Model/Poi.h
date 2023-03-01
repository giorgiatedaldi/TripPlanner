//
//  Poi.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 23/05/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Poi : NSObject <NSCoding, NSSecureCoding>

- (instancetype) initWithName:(NSString *) name
                     latitdue:(double) latitude
                    longitude:(double) longitude;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;

@end

NS_ASSUME_NONNULL_END
