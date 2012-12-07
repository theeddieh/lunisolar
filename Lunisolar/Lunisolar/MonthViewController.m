//
//  MonthViewController.m
//  Lunisolar
//
//  Created by Haley Smith on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthViewController.h"

@interface MonthViewController ()

@end

@implementation MonthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MonthView *currentView = (MonthView *)[self view];
    if([self currentYear] == 0){
        NSDate *today = [NSDate date];
        unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents = [calendar components:units fromDate:today];
        [self setCurrentMonth: [dateComponents month]];
        [self setCurrentYear: [dateComponents year]];
    }
    
    [currentView setCurrentMonth:[self currentMonth]];
    [currentView setCurrentYear:[self currentYear]]; 
    NSLog(@"Initialized to %d %d.", [self currentMonth], [self currentYear]);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    char *direction;
    MonthViewController *mvc = (MonthViewController *)[segue destinationViewController];

    if([[segue identifier] isEqualToString:@"MonthLeftSwipeSegue"]){
        direction = "left";
        if ([self currentMonth]+1 == 13) {
            [mvc setCurrentMonth: 1];
            [mvc setCurrentYear: [self currentYear]+1];
        }
        else {
            [mvc setCurrentMonth: [self currentMonth]+1];
            [mvc setCurrentYear:[self currentYear]];
        }
    }
    else if([[segue identifier] isEqualToString:@"MonthRightSwipeSegue"]){
        direction = "right";
        if ([self currentMonth]-1 == 0) {
            [mvc setCurrentMonth: 12];
            [mvc setCurrentYear: [self currentYear]-1];
        }
        else {
            [mvc setCurrentMonth: [self currentMonth]-1];
            [mvc setCurrentYear:[self currentYear]];
        }
    }
    NSLog(@"Current month = %d %d, swiped %s, set new month to %d %d.", 
          [self currentMonth], [self currentYear], direction, [mvc currentMonth], [mvc currentYear]);
}

- (int)currentMonth {
    return currentMonth;
}

- (void)setCurrentMonth:(int)newValue {
    currentMonth = newValue;
}

- (int)currentYear {
    return currentYear;
}

- (void)setCurrentYear:(int)newValue {
    currentYear = newValue;
}

@end
