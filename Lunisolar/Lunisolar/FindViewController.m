//
//  FindViewController.m
//  Lunisolar
//
//  Created by Haley Smith on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
//  Taken from Stack Overflow here: 
//  http://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview-on-iphone
//

#import "FindViewController.h"

@implementation UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController {
    // convenience function for casting and to "mask" the recursive function
    return (UIViewController *)[self traverseResponderChainForUIViewController];
}

- (id) traverseResponderChainForUIViewController {
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForUIViewController];
    } else {
        return nil;
    }
}
@end