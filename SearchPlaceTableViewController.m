//
//  SearchPlaceTableViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 21/05/21.
//

#import "SearchPlaceTableViewController.h"
#import <MapKit/MapKit.h>
#import "Poi.h"

@interface SearchPlaceTableViewController ()
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *matchingPlaces;
@property (nonatomic, strong) MKLocalSearchCompleter *completer;
@property(nonatomic, strong) NSArray <MKLocalSearchCompletion *> *searchResults;
@property(nonatomic, copy, nullable) MKPointOfInterestFilter *pointOfInterestFilter;

@end

@implementation SearchPlaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.matchingPlaces = [[NSArray alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.placeholder = @"Search for places";
    self.searchController.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
    self.completer = [[MKLocalSearchCompleter alloc]init];
    self.searchResults = [[NSArray<MKLocalSearchCompletion *> alloc]init];
    self.completer.delegate = self;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.completer.queryFragment = self.searchController.searchBar.text;

}

-(void)completerDidUpdateResults:(MKLocalSearchCompleter *)completer {
    self.searchResults = completer.results;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"subtitle contains ','"];
    self.searchResults = [completer.results filteredArrayUsingPredicate:predicate];
    [self.tableView reloadData];
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchPlaceCell" forIndexPath:indexPath];
    MKLocalSearchCompletion *result = [self.searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = result.title;
    cell.detailTextLabel.text = result.subtitle;
    return cell;
}

@synthesize delegate;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self dismissViewControllerAnimated:YES completion:nil];
    MKLocalSearchCompletion *result = [self.searchResults objectAtIndex:indexPath.row];
    
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] initWithCompletion:result];
    searchRequest.naturalLanguageQuery = self.searchController.searchBar.text;

    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (response) {
            Poi *poi;
            for (MKMapItem *item in response.mapItems) {
                CLLocationCoordinate2D coordinate = item.placemark.coordinate;
                NSLog(@"%@: %f,%f", item.name, coordinate.latitude, coordinate.longitude);
                poi = [[Poi alloc] initWithName:item.name latitdue:coordinate.latitude longitude:coordinate.longitude];
            }
            [self.delegate userDidSelectPlace:poi forTextField:self.theSender];
        }
        else if (error) {
            NSLog(@"Error search");
        }
    }];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
