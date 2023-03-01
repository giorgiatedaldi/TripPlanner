//
//  ManageNotifications.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 19/06/21.
//

#import "ManageNotifications.h"
#import <UserNotifications/UserNotifications.h>

@implementation ManageNotifications

bool isGrantedAccess;


-(void)requestAutohrization{
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound+UNNotificationPresentationOptionList+UNAuthorizationOptionBadge)
       completionHandler:^(BOOL granted, NSError * _Nullable error) {
        isGrantedAccess = granted;
    }];
}

-(void)createLocalNotificationForTripList:(TripList *)tripList{
    if (isGrantedAccess) {
        UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
        [center removeAllPendingNotificationRequests];
        NSArray *a = [tripList getAll];
        for (Trip *t in a){
            UNMutableNotificationContent* notificationContent = [[UNMutableNotificationContent alloc] init];
            notificationContent.title = [NSString localizedUserNotificationStringForKey:@"Are you ready?" arguments:nil];
            notificationContent.body = [NSString localizedUserNotificationStringForKey:[NSString stringWithFormat:@"Your trip %@ starts tomorrow!", t.name] arguments:nil];
            notificationContent.sound = [UNNotificationSound defaultSound];
            
            NSDateComponents* date = [[NSDateComponents alloc] init];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDate *dateOfNotification = [NSDate dateWithTimeInterval:-(60.0f*60.0f*24.0f) sinceDate:t.startDate];

            NSDateComponents *componentsNotificationDate = [calendar components:(NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute) fromDate:dateOfNotification];
            date.day = [componentsNotificationDate day];
            date.hour = 10;
            date.minute = 25;
            
            UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger
                   triggerWithDateMatchingComponents:date repeats:NO];
             
            UNNotificationRequest* request = [UNNotificationRequest
                                              requestWithIdentifier:[NSString stringWithFormat:@"Trip%@",t.name]
                                              content:notificationContent
                                              trigger:trigger];
            
            [center addNotificationRequest:request withCompletionHandler:nil];
        }
        
    }
}

@end
