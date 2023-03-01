//
//  ManageTextField.m
//  TripPlanner
//
//  Created by Giorgia Tedaldi on 18/05/21.
//

#import "ManageTextField.h"

@implementation ManageTextField

-(BOOL)textFieldIsOk:(NSString *)text {
    NSString *probablyEmpty = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL onlySpaces = [probablyEmpty isEqualToString:@""];
    
    if (text.length == 0 || onlySpaces) {
        return false;
    }
    else {
        return true;
    }
}

@end
