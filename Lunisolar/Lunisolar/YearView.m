//
//  Year.m
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "YearView.h"
#import "MonthView.h"
#import "GregorianCalendar.h"
#import "IslamicCalendar.h"
#import "HebrewCalendar.h"

@implementation YearView

int indent;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //Border size
    indent = 7;
    
    //Determine today's date and initialize calendar to current year
    [super drawRect:rect];
    
    [self drawYear:[self currentYear]];
    
}

- (void)drawYear:(int)year
{
    //Determine today's date to check whether it is current year
    NSDate *today = [NSDate date];
    unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:units fromDate:today];
    NSInteger day = [dateComponents day];
    NSInteger weekday = [dateComponents weekday];
    NSInteger month = [dateComponents month];
    
    NSInteger weeknum = day/7;
    NSLog(@"weekday: %d, weeknum: %d, month: %d", weekday, weeknum, month);
    
    //Bounds
    float width = self.bounds.size.width-(indent*2);
    float height = self.bounds.size.height-(indent*2)-100;
    
    //Height and width of each month
    float cellWidth = width/3;
    float cellHeight = height/4;
    
    //Set up context for drawing
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Create year label
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
//    UIFont *font =  [UIFont systemFontOfSize:100];
//    [[NSString stringWithFormat:@"%d", year] drawInRect:CGRectMake(indent, indent, width, 100-indent) withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
    
    //Get location of where each month should start
    NSArray *yearCells = [MonthView buildCells:width height:height x:indent y:indent+100 widthDev:3 heightDev:4];
    
    //Initialize Gregorian Cal
    id cal = [[GregorianCalendar alloc] init];
    int devHeight;
    
    NSArray *labels = [NSArray arrayWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
    
    //Building cell array of days for each month
    NSMutableArray *cell;
    NSMutableArray *months = [[NSMutableArray alloc] initWithCapacity:11];
    NSInteger labelHeight = 30;
    NSInteger i = 0;
    for (NSValue* val in yearCells) {
        //Get coords of where the month starts
        CGPoint p = [val CGPointValue];
        NSLog(@"month: %@ %.0f, %.0f",[labels objectAtIndex:i], p.x, p.y);
        
        devHeight = [cal numberOfWeeksInMonth:i+1 year:year];
        if (devHeight == 4) devHeight++;
        
        //Get coords of each day of the month
        cell = [MonthView buildCells:cellWidth-(indent*2) height:cellHeight-labelHeight-(indent) x:p.x+indent y:p.y+labelHeight widthDev:7 heightDev:devHeight];
        
        //Draw days of month
        NSLog(@"month: %@, daysinmonth: %d, cell: %d, devHeight %d", [labels objectAtIndex:i], [cal numberOfDaysInMonth:i+1 year:year], [cell count], devHeight);
        [MonthView injectDays:cell width:cellWidth/7 height:cellHeight/(devHeight+1) firstDate:[cal startWeekOfMonth:i+1 year:year].day firstDayofWeek:[cal firstDayOfMonth:i+1 year:year] daysInMonth:[cal numberOfDaysInMonth:i+1 year:year]];
        [months addObject:cell];
        
        //Draw month label
        [MonthView drawSquare:cellWidth-(indent*2) height:labelHeight-(indent) orginx:p.x+indent orginy:p.y];
        UIFont *font =  [UIFont systemFontOfSize:18.0];
        NSString *label = [labels objectAtIndex:i++];
        [label drawInRect:CGRectMake(p.x, p.y, cellWidth, cellHeight) withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
    }
    
    NSMutableArray *thisMonth;
    NSValue *v;
    CGPoint p;
    
    //Mark todays cell if it is this year
    if ([dateComponents year] == year){
        thisMonth = [months objectAtIndex:month-1];
        v = [thisMonth objectAtIndex:((weeknum*7)+weekday-1)];
        p = [v CGPointValue];
        NSLog(@"x: %f, y: %f", p.x, p.y);
        
        //Fill in today's cell
        CGContextSetAlpha(context, .5);
        CGContextSetLineWidth(context, 1);
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        devHeight = [cal numberOfWeeksInMonth:month year:year];
        if (devHeight == 4) devHeight++;
        CGRect todayRectangle;
        if (devHeight == 6){
            todayRectangle = CGRectMake(p.x,p.y,(cellWidth/7)-2,(cellHeight-labelHeight)/devHeight);
        } else{
            todayRectangle = CGRectMake(p.x,p.y,cellWidth/7,(cellHeight-labelHeight)/devHeight);  
        }
        CGContextAddRect(context, todayRectangle);
        CGContextFillPath(context);
    }
    
    NSArray * holidays;
    int index;
    
    //mark all islamic holidays
    id islam = [[IslamicCalendar alloc] init];
    holidays = [islam getHolidays:year];
    for (id day in holidays) {
        //find coords
        thisMonth = [months objectAtIndex:[day month]-1];
        index = ([cal firstDayOfMonth:[day month] year:year]-1) + ([day day]-1);
        NSLog(@"month: %@ total: %d, index: %d", [labels objectAtIndex:[day month]-1], [thisMonth count], index);
        v = [thisMonth objectAtIndex:index];
        p = [v CGPointValue];
        
        //Color holiday
        CGContextSetLineWidth(context, 1);
        CGContextSetFillColorWithColor(context, [UIColor  greenColor].CGColor);
        CGContextSetAlpha(context, .5);
        devHeight = [cal numberOfWeeksInMonth:month year:year];
        if (devHeight == 4) devHeight++;
        CGRect todayRectangle;
        if (devHeight == 6){
            todayRectangle = CGRectMake(p.x,p.y,(cellWidth/7)-2,(cellHeight-labelHeight)/devHeight);
        } else{
            todayRectangle = CGRectMake(p.x,p.y,cellWidth/7,(cellHeight-labelHeight)/devHeight);  
        }
        
        CGContextAddRect(context, todayRectangle);
        CGContextFillPath(context);
    }

    
    //Mark all gregorian holidays of the year
    holidays = [cal getHolidays:year];
    for (id day in holidays) {
        //find coords
        thisMonth = [months objectAtIndex:[day month]-1];
        index = ([cal firstDayOfMonth:[day month] year:year]-1) + ([day day]-1);
        NSLog(@"month: %@ total: %d, index: %d", [labels objectAtIndex:[day month]-1], [thisMonth count], index);
        v = [thisMonth objectAtIndex:index];
        p = [v CGPointValue];
        
        //Color holiday
        CGContextSetLineWidth(context, 1);
        CGContextSetFillColorWithColor(context, [UIColor  redColor].CGColor);
        CGContextSetAlpha(context, .5);
        devHeight = [cal numberOfWeeksInMonth:month year:year];
        if (devHeight == 4) devHeight++;
        CGRect todayRectangle;
        if (devHeight == 6){
            todayRectangle = CGRectMake(p.x,p.y,(cellWidth/7)-2,(cellHeight-labelHeight)/devHeight);
        } else{
            todayRectangle = CGRectMake(p.x,p.y,cellWidth/7,(cellHeight-labelHeight)/devHeight);  
        }      
        CGContextAddRect(context, todayRectangle);
        CGContextFillPath(context);
    }
    
    //mark all jewish holidays
    id hebrew = [[HebrewCalendar alloc] init];
    holidays = [hebrew getHolidays:year];
    for (id day in holidays) {
        //find coords
        thisMonth = [months objectAtIndex:[day month]-1];
        index = ([cal firstDayOfMonth:[day month] year:year]-1) + ([day day]-1);
        NSLog(@"month: %@ total: %d, index: %d", [labels objectAtIndex:[day month]-1], [thisMonth count], index);
        v = [thisMonth objectAtIndex:index];
        p = [v CGPointValue];
        
        //Color holiday
        CGContextSetLineWidth(context, 1);
        CGContextSetFillColorWithColor(context, [UIColor  orangeColor].CGColor);
        CGContextSetAlpha(context, .5);
        devHeight = [cal numberOfWeeksInMonth:month year:year];
        if (devHeight == 4) devHeight++;
        CGRect todayRectangle;
        if (devHeight == 6){
            todayRectangle = CGRectMake(p.x,p.y,(cellWidth/7)-2,(cellHeight-labelHeight)/devHeight);
        } else{
            todayRectangle = CGRectMake(p.x,p.y,cellWidth/7,(cellHeight-labelHeight)/devHeight);  
        }
        CGContextAddRect(context, todayRectangle);
        CGContextFillPath(context);
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


- (int)currentYear {
    if (currentYear == 0) {
        NSDate *today = [NSDate date];
        unsigned units = NSYearCalendarUnit;
        NSCalendar *calendar = [[NSCalendar alloc] 
                                initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents = [calendar components:units fromDate:today];
        currentYear = [dateComponents year];
    }
    return currentYear;
}

- (void)setCurrentYear:(int)newValue {
    currentYear = newValue;
}

@end
