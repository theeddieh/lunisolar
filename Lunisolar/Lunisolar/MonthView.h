//
//  Month.h
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "FindViewController.h"
#import "MonthViewController.h"

@interface MonthView : UIView{
    int currentMonth;
    int currentYear;
}

+ (NSMutableArray*)buildCells:(float)width height:(float)height x:(CGFloat)x y:(CGFloat)y widthDev:(int)widthDev heightDev:(int)heightDev;


+ (void)injectDays:(NSArray *)cells width:(float)width height:(float)height firstDate:(int)firstDate firstDayofWeek:(int)firstDayofWeek daysInMonth:(int)daysInMonth;


+ (void)drawSquare:(float)width height:(float)height orginx:(float)orginx orginy:(float)orginy;

- (int)currentMonth;

- (void)setCurrentMonth:(int)newValue;

- (int)currentYear;

- (void)setCurrentYear:(int)newValue;

@end
