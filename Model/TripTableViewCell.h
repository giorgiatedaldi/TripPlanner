//
//  TripTableViewCell.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 15/05/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TripTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *tripTitle;
@property (weak, nonatomic) IBOutlet UILabel *tripDate;

@end

NS_ASSUME_NONNULL_END
