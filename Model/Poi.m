//
//  Poi.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 23/05/21.
//

#import "Poi.h"

@implementation Poi

- (instancetype) initWithName:(NSString *) name
                     latitdue:(double) latitude
                    longitude:(double) longitude{
    if (self = [super init]) {
        _name = [name copy];
        _latitude = latitude;
        _longitude = longitude;
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeDouble:_latitude forKey:@"latitude"];
    [coder encodeDouble:_longitude forKey:@"longitude"];
}

-(instancetype) initWithCoder:(NSCoder *)coder {
    NSString *name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
    double latitude = [coder decodeDoubleForKey:@"latitude"];
    double longitude = [coder decodeDoubleForKey:@"longitude"];
    return [self initWithName:name latitdue:latitude longitude:longitude];
}

+(BOOL) supportsSecureCoding{
    return YES;
}

@end
