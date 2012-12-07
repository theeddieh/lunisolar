//
//  MonthView.m
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MonthView.h"
#import "GregorianCalendar.h"

@implementation MonthView

int indent = 7;
static int lineSize = 1;
CGFloat cellWidth;
CGFloat cellHeight;
NSInteger currentMonth;
NSInteger currentYear;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
     NSLog(@" %d, %d", [self currentMonth], [self currentYear]);
    
    // Basic month initialization
    float width = self.bounds.size.width-(indent*2);
    float height = self.bounds.size.height-(indent*2);
    
    id cal = [[GregorianCalendar alloc] init];
    int devHeight = [cal numberOfWeeksInMonth:[self currentMonth] year:[self currentYear]];
    NSLog(@"devHeight %d", devHeight);
    
    //building cell array
    NSArray * cells = [MonthView buildCells:width height:height-(height/(devHeight+1)) x:indent y:height/(devHeight+1)+indent widthDev:7 heightDev:devHeight];
    
    //draw day cells and label them
    [MonthView injectDays:cells width:width/7 height:height/(devHeight+1) firstDate:[cal startWeekOfMonth:[self currentMonth] year:[self currentYear]].day firstDayofWeek:[cal firstDayOfMonth:[self currentMonth] year:[self currentYear]] daysInMonth:[cal numberOfDaysInMonth:[self currentMonth] year:[self currentYear]]];
    
    //draw month label box
    //[MonthView drawSquare:width height:cellHeight-indent orginx:indent orginy:indent];
    
    //Get current date and initalize our cal to current month
    NSDate *today = [NSDate date];
    unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:units fromDate:today];
    NSInteger day = [dateComponents day];
    NSInteger weekday = [dateComponents weekday];
    NSInteger month = [dateComponents month];
    NSInteger year = [dateComponents year];
    
    //fill in month label
    NSArray *labels = [NSArray arrayWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    UIFont *font =  [UIFont systemFontOfSize:110.0];
    NSString *monthString = [labels objectAtIndex:currentMonth-1];
    NSString *label = [monthString stringByAppendingFormat:@" %d", currentYear];
    [label drawInRect:CGRectMake(0, indent+3, width, cellHeight) withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
    
    NSInteger weeknum = day/7; //height
    NSLog(@"weekday: %d, weeknum: %d, month: %d", weekday, weeknum, month);
    
    //fill in today's cell
    NSValue *v = [cells objectAtIndex:((weeknum*7)+weekday-1)];
    CGPoint p = [v CGPointValue];
    if (currentMonth == month && currentYear == year) {
       
        CGContextSetLineWidth(context, 1);
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextSetAlpha(context, .5);
        CGRect todayRectangle;
        NSLog(@"p.x: %f, p.y: %f", p.x, p.y);
        NSLog(@"cellWidth: %f, cellHeight: %f", cellWidth, cellHeight);
        todayRectangle = CGRectMake(p.x,p.y, width/7, (height-(height/(devHeight+1)))/devHeight);
        CGContextAddRect(context, todayRectangle);
        CGContextFillPath(context);
    }
    
    //Mark all holidays of the month
    NSArray * holidays = [cal getHolidays:currentYear];
    for (id day in holidays) {
        if ([day month] == currentMonth){
            //find coords
            NSLog(@"fdom %d, day date %d", [cal firstDayOfMonth:[self currentMonth] year:[self currentYear]], [day day]);
            v = [cells objectAtIndex:(([cal firstDayOfMonth:[self currentMonth] year:[self currentYear]]-1) + ([day day]-1))];
            p = [v CGPointValue];
            
            //Color holiday
            CGContextSetLineWidth(context, 1);
            CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            CGContextSetAlpha(context, .5);
            CGRect todayRectangle;
            NSLog(@"p.x: %f, p.y: %f", p.x, p.y);
            NSLog(@"cellWidth: %f, cellHeight: %f", cellWidth, cellHeight);
            todayRectangle = CGRectMake(p.x,p.y, width/7, (height-(height/(devHeight+1)))/devHeight);
            CGContextAddRect(context, todayRectangle);
            CGContextFillPath(context);
            
            //Write name of holiday
            CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
            font =  [UIFont systemFontOfSize:12.0];   
            [[day name] drawInRect:CGRectMake(p.x + indent, p.y + indent +24, width - (indent*2), height - (indent*2) - 24) withFont:font];

        }
    }

}

+ (NSMutableArray*)buildCells:(float)width height:(float)height x:(CGFloat)x y:(CGFloat)y widthDev:(int)widthDev heightDev:(int)heightDev
{
    float cellWidth = width/widthDev;
    float cellHeight = height/heightDev;
    
    
    NSMutableArray *cells = [[NSMutableArray alloc] initWithCapacity:(widthDev*heightDev)];
    
    for(int i = 0; i < heightDev; i++){
        for(int j = 0; j < widthDev; j++){
            CGPoint temp;
            temp.x = (CGFloat) x+ cellWidth*j;
            temp.y = (CGFloat) y+ cellHeight*i;
            
            // add to array
            [cells addObject:[NSValue valueWithCGPoint:temp]];
            
        }
    }
    
    return cells;
}

+ (void)injectDays:(NSMutableArray *)cells width:(float)width height:(float)height firstDate:(int)firstDate firstDayofWeek:(int)firstDayofWeek daysInMonth:(int)daysInMonth
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    bool oldMonth = TRUE;
    int day = firstDate;
    int i = 1;
    for (NSValue* val in cells) {
        
        //Calculate date
        if (oldMonth){
            CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
            if (i == firstDayofWeek){
                day = 1;
                oldMonth = FALSE;
                CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            }
        } else{
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            if (day > daysInMonth){
                day = 1;
                CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
            }
            if (i-firstDayofWeek > daysInMonth){
               CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor); 
            }
        }
        
        
        CGPoint p = [val CGPointValue];
        CGContextSetLineWidth(context, 1);
        CGRect rectangle = CGRectMake(p.x,p.y, width, height);
        UIView *myView = [[UIView alloc] initWithFrame:rectangle];
        myView.backgroundColor = [UIColor blueColor];
        //[ addSubview:myView];
        //[myView release];
        
        CGContextAddRect(context, rectangle);
        CGContextStrokePath(context);
        CGContextFillRect(context, rectangle);
        
        // put label in cell
        CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
        UIFont *font =  [UIFont systemFontOfSize:12.0];                
        [[NSString stringWithFormat:@"%d", day] drawInRect:CGRectMake(p.x + indent, p.y + indent, width - (indent*2), height - (indent*2)) withFont:font];
        
        i++;
        day++;
        //NSLog(@"%.0f, %.0f", p.x, p.y);
    }
    CGContextStrokePath(context);
    
}

+ (void)drawSquare:(float)width height:(float)height orginx:(float)orginx orginy:(float)orginy
{    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rectangle = CGRectMake(orginx,orginy, width, height);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rectangle);
    
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
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

