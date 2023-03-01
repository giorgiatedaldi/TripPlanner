//
//  StopList.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 12/05/21.
//

#import <Foundation/Foundation.h>
#import "Stop.h"

NS_ASSUME_NONNULL_BEGIN

@interface StopList : NSObject <NSCoding, NSSecureCoding>
@property (nonatomic, strong) NSMutableArray *stopList;
- (instancetype)initWithStopList:(NSMutableArray *)stopList;
- (long)size;
- (NSArray *)getAll;
- (void)add:(Stop *)s;
- (Stop *)getAtIndex:(NSInteger)index;
- (BOOL)isEmpty;
- (void)removeAtIndex:(NSInteger)index;
- (void)copyStopList:(StopList *)toCopy;
- (void)sortByArrivalDate;

@end

NS_ASSUME_NONNULL_END
