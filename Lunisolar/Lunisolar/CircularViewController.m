//
//  CircularViewController.m
//  Lunisolar
//
//  Created by Haley Smith on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CircularViewController.h"
#import "CircularYearView.h"

@interface CircularViewController ()

@end

@implementation CircularViewController
@synthesize yearField;

static int playClicked = 0;
static NSTimer *timer;


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
    CircularYearView *view = (CircularYearView *) [self view];
    NSString *str = [[NSString alloc] initWithFormat:@"%d",[view year]];
    [yearField setText:str];
}

- (void)viewDidUnload
{
    [self setYearField:nil];
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
    // Advances view by one year
    CircularYearView *view = (CircularYearView *) [self view];
    [view setYear:[view year]+1];
    NSString *str = [[NSString alloc] initWithFormat:@"%d",[view year]];
    [yearField setText:str];
    [view setNeedsDisplay];
}

-(IBAction)minusButtonPressed:(id)sender
{
    // Decrements view by one year
    CircularYearView *view = (CircularYearView *) [self view];
    [view setYear:[view year]-1];
    NSString *str = [[NSString alloc] initWithFormat:@"%d",[view year]];
    [yearField setText:str];
    [view setNeedsDisplay]; 
}

-(IBAction)playForwardButtonPressed:(id)sender
{
    playClicked++;
    
    if (playClicked % 2 == 0)
    {
        [timer invalidate];
    }
    else 
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(jumpAhead:) userInfo:nil repeats:YES]; 
    }
}

-(IBAction)playBackwardsButtonPressed:(id)sender
{
    playClicked++;
    
    if (playClicked % 2 == 0)
    {
        [timer invalidate];
    }
    else 
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(jumpBack:) userInfo:nil repeats:YES]; 
    }
}

-(void)jumpAhead:(NSTimer*)timer {
    
    // Advances view by one year
    CircularYearView *view = (CircularYearView *) [self view];
    [view setYear:[view year]+1];
    NSString *str = [[NSString alloc] initWithFormat:@"%d",[view year]];
    [yearField setText:str];
    [view setNeedsDisplay];
}

-(void)jumpBack:(NSTimer*)timer {
    // Decrements view by one year
    CircularYearView *view = (CircularYearView *) [self view];
    [view setYear:[view year]-1];
    NSString *str = [[NSString alloc] initWithFormat:@"%d",[view year]];
    [yearField setText:str];
    [view setNeedsDisplay];
    
}

-(IBAction)catholicButtonPressed:(id)sender
{
    CircularYearView *view = (CircularYearView *) [self view];
    [view setShowGregorian:![view showGregorian]];
    [view setNeedsDisplay];
}

-(IBAction)hebrewButtonPressed:(id)sender
{
    /*
    CircularYearView *view = (CircularYearView *) [self view];
    NSLog(@"showHebrew = %s", [view showHebrew] ? "true" : "false");
    //@" %s", BOOL_VAL ? "true" : "false"
    [view setShowHebrew:![view showHebrew]];
    NSLog(@"new showHebrew = %s", [view showHebrew] ? "true" : "false");
    
    [view setNeedsDisplay];
    */
    
    CircularYearView *view = (CircularYearView *) [self view];
    [view setShowHebrew:![view showHebrew]];
    [view setNeedsDisplay];
     
}

-(IBAction)islamicButtonPressed:(id)sender
{
    CircularYearView *view = (CircularYearView *) [self view];
    [view setShowIslamic:![view showIslamic]];
    [view setNeedsDisplay];
}

-(IBAction)americanButtonPressed:(id)sender
{
    CircularYearView *view = (CircularYearView *) [self view];
    [view setShowHindu:![view showHindu]];
    [view setNeedsDisplay];
}

-(IBAction)chineseButtonPressed:(id)sender
{
    CircularYearView *view = (CircularYearView *) [self view];
    [view setShowChinese:![view showChinese]];
    [view setNeedsDisplay];
}

-(IBAction)lunarButtonPressed:(id)sender
{
    CircularYearView *view = (CircularYearView *) [self view];
    [view setShowLunar:![view showLunar]];
    [view setNeedsDisplay];
}

-(IBAction)labelButtonPressed:(id)sender
{
    CircularYearView *view = (CircularYearView *) [self view];
    [view setShowLabels:![view showLabels]];
    [view setNeedsDisplay];
}

-(void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    NSLog(@"In popoverDone");
    CircularYearView *view = (CircularYearView *) [self view];
    //int year = [[popoverController yearText] intValue];
    //NSLog(@"New Year setting to %d", year);
    //[view setYear:year];
    [view setNeedsDisplay];
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TouchesBegan");
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    /*
    CGAffineTransform scaleTrans =
    CGAffineTransformMakeScale(scaleFactor, scaleFactor);
    CGAffineTransform rotateTrans = 
    CGAffineTransformMakeRotation(angle * M_PI / 180);
    boxView.transform = CGAffineTransformConcat(scaleTrans, rotateTrans);
    angle = (angle == 180 ? 360 : 180);
    scaleFactor = (scaleFactor == 2 ? 1 : 2);
    boxView.center = location;
    [UIView commitAnimations];*/
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
    CircularYearView *view = (CircularYearView *) [self view];
    [view setYear:newYear];
    [textField setText:[textField text]];
    [view setNeedsDisplay];
}


@end
