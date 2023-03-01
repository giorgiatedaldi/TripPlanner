//
//  Visit.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import "Visit.h"

@implementation Visit

-(instancetype) initWithLocation:(Poi *)location
                     arrivalDate:(NSDate *)arrivalDate
                   departureDate:(NSDate *)departureDate
                     placeOfStay:(NSString *)placeOfStay {
    
    if (self = [super init]) {
        _location = location;
        _arrivalDate = [arrivalDate copy];
        _departureDate = [departureDate copy];
        _placeOfStay = [placeOfStay copy];
    }
    
    return self;
}

-(instancetype) initWithLocation:(Poi *)location
                     arrivalDate:(NSDate *)arrivalDate
                   departureDate:(NSDate *)departureDate {
    
    return [self initWithLocation:location
                      arrivalDate:arrivalDate
                    departureDate:departureDate
                      placeOfStay:@""];
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_location forKey:@"location"];
    [coder encodeObject:_arrivalDate forKey:@"arrivalDate"];
    [coder encodeObject:_departureDate forKey:@"departureDate"];
    [coder encodeObject:_placeOfStay forKey:@"placeOfStay"];
}

-(instancetype)initWithCoder:(NSCoder *)coder {
    Poi *location = [coder decodeObjectOfClass:[Poi class] forKey:@"location"];
    NSDate *arrivalDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"arrivalDate"];
    NSDate *departureDate = [coder decodeObjectOfClass:[NSDate class] forKey:@"departureDate"];
    NSString *placeOfStay = [coder decodeObjectOfClass:[NSString class] forKey:@"placeOfStay"];
    return [self initWithLocation:location
                      arrivalDate:arrivalDate
                    departureDate:departureDate
                      placeOfStay:placeOfStay];
}

+(BOOL)supportsSecureCoding{
    return  YES;
}

@end
