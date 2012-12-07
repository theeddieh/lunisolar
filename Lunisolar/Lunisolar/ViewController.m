//
//  ViewController.m
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "CircularYear.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"Didot", 30.0f, NULL); // 1-2
    NSDictionary *attrDictionary = [NSDictionary dictionaryWithObjectsAndKeys: (__bridge id)fontRef, (NSString *)kCTFontAttributeName, (id)[[UIColor blackColor] CGColor], (NSString *)(kCTForegroundColorAttributeName), nil]; // 2-2
    CFRelease(fontRef); // 3-2
    
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"HELLO WORLD! GOD WILL SAVE US! Everybody loves iNVASIVECODE!" attributes:attrDictionary]; // 12-1
    [(CircularYear *)[self view] setAttString:attString]; // 13-1
    //[attString release]; // 14-1
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
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

@end
