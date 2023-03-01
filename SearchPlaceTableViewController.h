//
//  SearchPlaceTableViewController.h
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 21/05/21.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Poi.h"
NS_ASSUME_NONNULL_BEGIN

@protocol sendPlaceDelegate <NSObject>

-(void)userDidSelectPlace:(Poi *)mapItem forTextField:(id)sender;

@end

@interface SearchPlaceTableViewController : UITableViewController <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, MKLocalSearchCompleterDelegate>

@property (nonatomic, weak) id <sendPlaceDelegate> delegate;
@property (nonatomic, strong) UITextField *theSender;

@end

NS_ASSUME_NONNULL_END
