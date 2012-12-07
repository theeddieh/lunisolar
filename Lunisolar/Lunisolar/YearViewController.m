//
//  YearViewController.m
//  Lunisolar
//
//  Created by Haley Smith on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YearViewController.h"
#import "YearView.h"

@interface YearViewController ()

@end

@implementation YearViewController
@synthesize yearTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    YearView *view = (YearView *) [self view];
    NSString *str = [[NSString alloc] initWithFormat:@"%d",[view currentYear]];
    [yearTextField setText:str];
}

- (void)viewDidUnload
{
    [self setYearTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
    {
        return NO;
    }
    
    return YES;
}

-(IBAction)plusButtonPressed:(id)sender
{
    YearView *view = (YearView *) [self view];
    [view setCurrentYear:[view currentYear]+1];
    
    NSString *str = [[NSString alloc] initWithFormat:@"%d",[view currentYear]];
    [yearTextField setText:str];
    
    
    [view setNeedsDisplay];
}

-(IBAction)minusButtonPressed:(id)sender
{
    YearView *view = (YearView *) [self view];
    [view setCurrentYear:[view currentYear]-1];
    
    NSString *str = [[NSString alloc] initWithFormat:@"%d",[view currentYear]];
    [yearTextField setText:str];
    
    [view setNeedsDisplay];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)textFieldDidEndEditing:(UITextField *)textField:(id)sender
{
    int newYear = [[textField text] intValue];
    YearView *view = (YearView *) [self view];
    [view setCurrentYear:newYear];
    [textField setText:[textField text]];
    [view setNeedsDisplay];
}

@end
