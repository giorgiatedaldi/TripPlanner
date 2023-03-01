//
//  Stop.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import "Stop.h"

@implementation Stop

-(instancetype) initWithMyTravel:(Travel *)myTravel
                         myVisit:(Visit *)myVisit {
    if (self = [super init]) {
        _myTravel = myTravel;
        _myVisit = myVisit;
    }
    
    return self;
}

- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.myVisit.location.latitude;
    coordinate.longitude = self.myVisit.location.longitude;
    return coordinate;
}

-(NSString *) title {
    return self.myVisit.location.name;
}

-(void) encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_myTravel forKey:@"myTravel"];
    [coder encodeObject:_myVisit forKey:@"myVisit"];

}

-(instancetype)initWithCoder:(NSCoder *)coder{
    Travel *myTravel = [coder decodeObjectOfClass:[Travel class] forKey:@"myTravel"];
    Visit *myVisit = [coder decodeObjectOfClass:[Visit class] forKey:@"myVisit"];
    return [self initWithMyTravel:myTravel
                          myVisit:myVisit];
}

+(BOOL)supportsSecureCoding {
    return YES;
}

@end
