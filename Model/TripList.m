//
//  TripList.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import "TripList.h"


@interface TripList()

@property (nonatomic, strong) NSMutableArray *tripList;

@end

@implementation TripList

- (instancetype)init{
    if(self = [super init]){
        _tripList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (long)size{
    return self.tripList.count;
}

- (NSArray *)getAll{
    return self.tripList;
}

- (void)add:(Trip *)t{
    [self.tripList addObject:t];
}

- (Trip *)getAtIndex:(NSInteger)index{
    return [self.tripList objectAtIndex:index];
}

- (void) removeAtIndex:(NSInteger)index {
    return [self.tripList removeObjectAtIndex:index];
}

-(void) copyTripList:(TripList *)toCopy {
    for (int i = 0; i<toCopy.tripList.count; i++) {
        [self.tripList addObject:[toCopy.tripList objectAtIndex:i]];
    }
}

@end
