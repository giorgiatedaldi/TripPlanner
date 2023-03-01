//
//  DurationTableViewCell.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 13/05/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DurationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fromOrToLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

NS_ASSUME_NONNULL_END
