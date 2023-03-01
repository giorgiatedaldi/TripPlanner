//
//  VisitDateTableViewCell.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 14/05/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VisitDateTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *arriveDate;
@property (weak, nonatomic) IBOutlet UITextView *departureDate;

@end

NS_ASSUME_NONNULL_END
