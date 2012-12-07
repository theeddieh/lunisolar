//
//  FindViewController.h
//  Lunisolar
//
//  Created by Haley Smith on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//
//  Taken from Stack Overflow here: 
//  http://stackoverflow.com/questions/1340434/get-to-uiviewcontroller-from-uiview-on-iphone
//

#import <UIKit/UIKit.h>

@interface UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
@end
