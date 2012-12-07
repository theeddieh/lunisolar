//
//  CircularYear.h
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
#import "Day.h"

@interface CircularYearView : UIView {
    //format for month labels
    NSAttributedString *attString; 
    IBOutlet UITextField* yearField;
    
    //circle grid creation perams
    int offset;
    int decrement; //ONLY USE EVEN NUMBERS
    int totalSize; //Adjust to resize object
    int rings;
    int radius;
    int cellHeight;
    CGPoint center;
    int year;
    double weeks;
    
    // holiday display booleans
    BOOL showGregorian;
    BOOL showHebrew;
    BOOL showIslamic;
    BOOL showAmerican;
    BOOL showHindu;
    BOOL showChinese;
    BOOL showLunar;
    
    BOOL showLabels;
}

@property (nonatomic, retain) IBOutlet NSAttributedString *attString;

@property (nonatomic, retain) IBOutlet UITextField *yearField;

- (void)drawYear:(int)year;

- (void)markday:(NSInteger)dof dev:(double)dev;

- (void)makeLabel:(int)i j:(int)j h:(double)h walker:(Day *)walker holidaylabels:(NSMutableArray *)holidaylabels;

- (int)year;

- (void)setYear:(int)newValue;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (BOOL)showGregorian;

- (void)setShowGregorian:(BOOL)newValue;

- (BOOL)showHebrew;

- (void)setShowHebrew:(BOOL)newValue;

- (BOOL)showIslamic;

- (void)setShowIslamic:(BOOL)newValue;

- (BOOL)showAmerican;

- (void)setShowAmerican:(BOOL)newValue;

- (BOOL)showHindu;

- (void)setShowHindu:(BOOL)newValue;

- (BOOL)showChinese;

- (void)setShowChinese:(BOOL)newValue;

- (BOOL)showLunar;

- (void)setShowLunar:(BOOL)newValue;

- (BOOL)showLabels;

- (void)setShowLabels:(BOOL)newValue;

@end
