//
//  StopList.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import "StopList.h"

@interface StopList()


@end

@implementation StopList

- (instancetype)init{
    if(self = [super init]){
        _stopList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithStopList:(NSMutableArray *)stopList{
    if(self = [super init]){
        _stopList = stopList;
    }
    return self;
}


- (long)size{
    return self.stopList.count;
}

- (NSArray *)getAll{
    return self.stopList;
}

- (void)add:(Stop *)s{
    [self.stopList addObject:s];
}

- (Stop *)getAtIndex:(NSInteger)index{
    return [self.stopList objectAtIndex:index];
}

- (void) removeAtIndex:(NSInteger)index {
    return [self.stopList removeObjectAtIndex:index];
}

-(BOOL)isEmpty{
    if (self.stopList.count > 0) {
        return false;
    }
    else {
        return true;
    }
}

-(void) copyStopList:(StopList *)toCopy {
    for (int i = 0; i<toCopy.stopList.count; i++) {
        [self.stopList addObject:[toCopy.stopList objectAtIndex:i]];
    }
}

- (void)sortByArrivalDate{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"myVisit.arrivalDate" ascending:TRUE];
    [self.stopList sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_stopList forKey:@"stopList"];
}

-(instancetype)initWithCoder:(NSCoder *)coder {
    NSSet *set = [NSSet setWithObjects:[StopList class], [Stop class], [NSMutableArray class], nil];
    NSMutableArray *stopList = [coder decodeObjectOfClasses:set forKey:@"stopList"];
    return [self initWithStopList:stopList];;
}

+(BOOL) supportsSecureCoding{
    return YES;
}

@end
