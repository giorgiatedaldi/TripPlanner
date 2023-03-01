//
//  ManageDates.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 17/05/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManageDates : NSObject

-(BOOL)startDate:(NSDate *)start isBeforeEndDate:(NSDate *)end;
-(BOOL)startDate:(NSDate *)start isLaterThanEndDate:(NSDate *)end;
-(BOOL)startDate:(NSDate *)start isEqualToEndDate:(NSDate *)end;
-(NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format;
@end

NS_ASSUME_NONNULL_END
