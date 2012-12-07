//
//  MonthViewController.h
//  Lunisolar
//
//  Created by Haley Smith on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MonthView.h"

@interface MonthViewController : UIViewController{
    int currentMonth;
    int currentYear;
}

- (int)currentMonth;

- (void)setCurrentMonth:(int)newValue;

- (int)currentYear;

- (void)setCurrentYear:(int)newValue;

- (IBAction)handleSwipe:(UISwipeGestureRecognizer *)recognizer;

@end
