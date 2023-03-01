//
//  Trip.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import "Trip.h"

@implementation Trip

-(instancetype) initWithName:(NSString *)name
             tripDescription:(NSString *)tripDescription
                   startDate:(NSDate *)startDate
                     endDate:(NSDate *)endDate
                     myStops:(StopList *)myStops {
    
    if (self = [super init]) {
        _name = [name copy];
        _tripDescription = [tripDescription copy];
        _startDate = [startDate copy];
        _endDate = [endDate copy];
        _myStops = myStops;
    }
    
    return self;
}

#pragma mark - NSCoding

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_tripDescription forKey:@"tripDescription"];
    [coder encodeObject:_startDate forKey:@"startDate"];
    [coder encodeObject:_endDate forKey:@"endDate"];
    [coder encodeObject:_myStops forKey:@"myStops"];
}

-(instancetype)initWithCoder:(NSCoder *)coder {
    NSString *name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
    NSString *tripDescription = [coder decodeObjectOfClass:[NSString class] forKey:@"tripDescription"];
    NSDate *startDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"startDate"];
    NSDate *endDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"endDate"];
    StopList *myStops = [coder decodeObjectOfClass:[StopList class] forKey:@"myStops"];
    return [self initWithName:name
              tripDescription:tripDescription
                    startDate:startDate
                      endDate:endDate
                      myStops:myStops];

}

#pragma mark - NSSecureCoding
+(BOOL)supportsSecureCoding {
    return YES;
}

@end
