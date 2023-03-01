//
//  DataSource.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 11/06/21.
//

#import "DataSource.h"
#import "Trip.h"
@implementation DataSource

-(TripList*)loadObject{
    NSError *error;
    NSData *data= [NSUserDefaults.standardUserDefaults valueForKey:@"data"];
    NSSet *set = [NSSet setWithObjects:[StopList class], [Trip class], [NSMutableArray class], nil];
    NSArray *a = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:data error:&error];
    TripList *tripList = [[TripList alloc]init];
    NSLog(@"data loaded: %@ %@", a, error);
    for (Trip *t in a) {
        [tripList add:t];
    }
    return tripList;
    
}

-(void) storeObject:(TripList *)tripList {
    NSError *error;
    NSArray *tripArray = [tripList getAll];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tripArray requiringSecureCoding:YES error:&error];
    
    [NSUserDefaults.standardUserDefaults setObject:data forKey:@"data"];
    [NSUserDefaults.standardUserDefaults synchronize];
    NSLog(@"data stored: %@", data);

}


/*-(NSString *)filePath {
    
    NSString        *filePath = [[[self applicationDocumentsDirectory] path] stringByAppendingString:@"/repository"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory,  NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"myFile"];
    NSLog(@"%@ filepath: ", filePath);
    return filePath;
}*/

@end
