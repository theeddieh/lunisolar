//
//  CircularViewController.h
//  Lunisolar
//
//  Created by Haley Smith on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerViewController.h"

@interface CircularViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *yearField;

-(IBAction)plusButtonPressed:(id)sender;

-(IBAction)minusButtonPressed:(id)sender;

-(IBAction)playForwardButtonPressed:(id)sender;

-(IBAction)playBackwardsButtonPressed:(id)sender;

-(void)jumpAhead:(NSTimer*)timer;

-(void)jumpBack:(NSTimer*)timer;

-(IBAction)catholicButtonPressed:(id)sender;

-(IBAction)hebrewButtonPressed:(id)sender;

-(IBAction)islamicButtonPressed:(id)sender;

-(IBAction)americanButtonPressed:(id)sender;

-(IBAction)chineseButtonPressed:(id)sender;

-(IBAction)lunarButtonPressed:(id)sender;

-(IBAction)labelButtonPressed:(id)sender;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

-(IBAction)textFieldDidEndEditing:(UITextField *)textField:(id)sender;

@end
