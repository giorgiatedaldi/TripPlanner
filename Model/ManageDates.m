//
//  ManageDates.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 17/05/21.
//

#import "ManageDates.h"

@implementation ManageDates

-(BOOL)startDate:(NSDate *)start isBeforeEndDate:(NSDate *)end{
    if ([start compare: end] == NSOrderedDescending) {
        return false;
    }
    else {
        return true;
    }
}

-(BOOL)startDate:(NSDate *)start isLaterThanEndDate:(NSDate *)end{
    if ([start compare: end] == NSOrderedAscending) {
        return false;
    }
    else {
        return true;
    }
}

-(BOOL)startDate:(NSDate *)start isEqualToEndDate:(NSDate *)end {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger comps = (NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear);

    NSDateComponents *startComponents = [calendar components:comps fromDate: start];
    NSDateComponents *endComponents = [calendar components:comps fromDate: end];

    start = [calendar dateFromComponents:startComponents];
    end = [calendar dateFromComponents:endComponents];
    if ([start compare:end] == NSOrderedSame){
        return true;
    }
    else {
        return false;
    }

}

-(NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format {
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:format];
    return  [df stringFromDate:date];
    
}

@end
