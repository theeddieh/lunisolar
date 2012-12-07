//
//  PickerViewController.h
//  Lunisolar
//
//  Created by Haley Smith on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerViewController;

@interface PickerViewController : UIViewController{
    id <UIPopoverControllerDelegate> delegate;
    
    NSString *yearText;
    
    IBOutlet UIPickerView *calendarPicker;

    IBOutlet UITextField *yearField;
    
    IBOutlet UIButton *okButton;
    
    NSMutableArray *calendars;
}

@property (nonatomic, retain) id delegate;

- (NSString *)yearText;

- (void)setYearText:(NSString *)newValue;

@end
