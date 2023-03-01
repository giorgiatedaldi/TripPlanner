//
//  TravelDetailTableViewCell.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 14/05/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TravelDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *arrivalDate;
@property (weak, nonatomic) IBOutlet UITextView *arrivalLocation;
@property (weak, nonatomic) IBOutlet UITextView *departureLocation;

@end

NS_ASSUME_NONNULL_END
