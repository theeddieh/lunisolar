//
//  PickerViewController.m
//  Lunisolar
//
//  Created by Haley Smith on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickerViewController.h"
#import "CircularViewController.h"

@interface PickerViewController ()

@end

@implementation PickerViewController

@synthesize delegate;

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [calendars count];
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [calendars objectAtIndex:row];
}

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

    // create the calendar options here
    calendars = [[NSMutableArray alloc] init];
    [calendars addObject:@"Gregorian"];
    [calendars addObject:@"Jewish"];
    [calendars addObject:@"Muslim"];
    [calendars addObject:@"Chinese"];
    [calendars addObject:@"Catholic"];

}

- (void)viewDidUnload
{
    yearField = nil;
    okButton = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(IBAction)okButtonPressed:(id)sender
{
    // capture year
    // dismiss view
    
    if([yearField.text length] != 0)
    {
        [self setYearText:yearField.text];
    }
    
    int yeartest = [yearText intValue];
    NSLog(@"New Year: %d", yeartest);
    
    CircularViewController *parent = (CircularViewController *) [self parentViewController];
}

- (NSString *)yearText {
    return yearText;
}

- (void)setYearText:(NSString *)newValue {
    yearText = newValue;
}

@end
