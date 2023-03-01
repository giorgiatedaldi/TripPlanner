//
//  Travel.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import "Travel.h"

@implementation Travel

-(instancetype) initWithDepartureLocation:(Poi *)departureLocation
                          arrivalLocation:(Poi *)arrivalLocation
                              arrivalDate:(NSDate *)arrivalDate
                           transportation:(NSString *)transportation{
    
    if (self = [super init]) {
        _departureLocation = departureLocation;
        _arrivalLocation = arrivalLocation;
        _arrivalDate = [arrivalDate copy];
        _transportation = [transportation copy];
    }
    
    return self;
}

-(instancetype) initWithDepartureLocation:(Poi *)departureLocation
                          arrivalLocation:(Poi *)arrivalLocation
                              arrivalDate:(NSDate *)arrivalDate {
    
    return [self initWithDepartureLocation:departureLocation
                           arrivalLocation:arrivalLocation
                               arrivalDate:arrivalDate
                                transportation:@""];
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_departureLocation forKey:@"departureLocation"];
    [coder encodeObject:_arrivalLocation forKey:@"arrivalLocation"];
    [coder encodeObject:_arrivalDate forKey:@"arrivalDate"];
    [coder encodeObject:_transportation forKey:@"transportation"];
}

-(instancetype)initWithCoder:(NSCoder *)coder {
    Poi *departureLocation = [coder decodeObjectOfClass:[Poi class] forKey:@"departureLocation"];
    Poi *arrivalLocation = [coder decodeObjectOfClass:[Poi class] forKey:@"arrivalLocation"];
    NSDate *arrivalDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"arrivalDate"];
    NSString *transportation = [coder decodeObjectOfClass:[NSString class] forKey:@"transportation"];
    return [self initWithDepartureLocation:departureLocation
                           arrivalLocation:arrivalLocation
                               arrivalDate:arrivalDate transportation:transportation];
}

+(BOOL)supportsSecureCoding {
    return YES;
}
    

@end
