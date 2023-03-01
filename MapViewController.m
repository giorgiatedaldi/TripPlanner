//
//  MapViewController.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 24/05/21.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "StopDetailsTableViewController.h"

@interface MapViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, readonly) MKPolyline *polyline;


- (void) centerMapToLocation:(CLLocationCoordinate2D) CLLocationCoordinate2D
                        zoom:(double) zoom;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
       
    Stop *firstStop = [self.stops objectAtIndex:0];
    CLLocationCoordinate2D coordinateToCenter;
    coordinateToCenter.latitude = firstStop.myVisit.location.latitude;
    coordinateToCenter.longitude = firstStop.myVisit.location.longitude;
    [self centerMapToLocation:coordinateToCenter zoom:30];
    CLLocationCoordinate2D coordinates[[self.stops count]];
    
    for (NSInteger i=0; i<[self.stops count]; i++) {
        if ([self.stops[i] isKindOfClass:[Stop class]]) {
            Stop *s = (Stop *)self.stops[i];
            [self.mapView addAnnotation:s];
            CLLocationCoordinate2D coordinate;
            coordinate.latitude = s.myVisit.location.latitude;
            coordinate.longitude = s.myVisit.location.longitude;
            coordinates[i] = coordinate;
            NSLog(@"%s: got %@ stop lat: %f long %f", __FUNCTION__,s.myVisit.location.name ,s.myVisit.location.latitude, s.myVisit.location.longitude);
        }
    }
    MKGeodesicPolyline *line = [MKGeodesicPolyline polylineWithCoordinates:coordinates count:[self.stops count]];
    [self.mapView addOverlay:line];
}

-(MKOverlayRenderer*)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *polylineRenderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    polylineRenderer.strokeColor = [UIColor redColor];
    polylineRenderer.lineWidth = 3.0;
    polylineRenderer.alpha = 0.5;
    return polylineRenderer;
}

- (void) centerMapToLocation:(CLLocationCoordinate2D)location zoom:(double)zoom {
    MKCoordinateRegion mapRegion;
    mapRegion.center = location;
    mapRegion.span.latitudeDelta = zoom;
    mapRegion.span.longitudeDelta = zoom;
    [self.mapView setRegion:mapRegion];
    
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
   
    static NSString * AnnotationIdentifier = @"MapAnnotationView";
    
    MKAnnotationView *view = [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!view) {
        view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                            reuseIdentifier:AnnotationIdentifier];
        
        view.canShowCallout = YES;
    }
    
    view.annotation = annotation;
    view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
    
    return view;
    
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    if ([control isEqual:view.rightCalloutAccessoryView]) {
        [self performSegueWithIdentifier:@"ShowStopDetailFromMap" sender:view];
    }
}



#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     if ([segue.identifier isEqualToString:@"ShowStopDetailFromMap"]) {
         if ([segue.destinationViewController isKindOfClass:[StopDetailsTableViewController class]]) {
             StopDetailsTableViewController *vc = (StopDetailsTableViewController *)segue.destinationViewController;
             if ([sender isKindOfClass:[MKAnnotationView class]]) {
                 MKAnnotationView *view = (MKAnnotationView *)sender;
                 id<MKAnnotation> annotation = view.annotation;
                 if ([annotation isKindOfClass:[Stop class]]) {
                     Stop *s = (Stop *)annotation;
                     vc.theVisit = s.myVisit;
                     vc.theTravel = s.myTravel;
                 }
                 
             }
             
         }
     }
 }

@end
