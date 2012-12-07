//
//  Year.m
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Year.h"
#import "Month.h"

@implementation Year

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
 //Outline
 float width = self.bounds.size.width;
 float height = self.bounds.size.height;
 NSLog(@"width: %f, height: %f", width, height);
 
 float cellWidth = width/3;
 float cellHeight = height/4;
 
 // building cell array
 NSMutableArray *cell;
 NSMutableArray *yearCells = [Month buildCells:width height:height x:0 y:0 widthDev:3 heightDev:4];
    
 NSMutableArray *months = [[NSMutableArray alloc] initWithCapacity:11];
 NSArray *labels = [NSArray arrayWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
 
 NSInteger labelHeight = 30;
 NSInteger i = 0;
 for (NSValue* val in yearCells) {
 CGPoint p = [val CGPointValue];
 NSLog(@"%.0f, %.0f", p.x, p.y);
 
 //Draw month label
 NSInteger indent = 7;
 NSInteger lineSize = 1;
 
 CGContextRef context = UIGraphicsGetCurrentContext();
 CGContextSetLineWidth(context, lineSize);
 CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
     
 CGContextMoveToPoint(context, p.x+indent, p.y + 1);
 CGContextAddLineToPoint(context, p.x+indent, p.y + labelHeight - indent);
 
 CGContextMoveToPoint(context, p.x+indent, p.y+ 1);
 CGContextAddLineToPoint(context, p.x + cellWidth-indent, p.y+ 1);
 
 CGContextMoveToPoint(context, p.x+indent, p.y+ labelHeight - indent);
 CGContextAddLineToPoint(context, p.x + cellWidth-indent, p.y+ labelHeight - indent);
 
 CGContextMoveToPoint(context, p.x+ cellWidth-indent, p.y+ 1);
 CGContextAddLineToPoint(context, p.x + cellWidth-indent, p.y+ labelHeight - indent);
 CGContextStrokePath(context);
 
 
 //Draw each month
 cell = [Month drawGrid:cellWidth height:cellHeight-labelHeight x:p.x y:p.y+labelHeight];
 [months addObject:cell];
 
 //Label each month
 UIFont *font =  [UIFont systemFontOfSize:18.0];
 NSString *label = [labels objectAtIndex:i++];
 [label drawInRect:CGRectMake(p.x, p.y, cellWidth, cellHeight) withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
 }
 
 //Determine today's cell
 NSDate *today = [NSDate date];
 unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
 NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
 NSDateComponents *dateComponents = [calendar components:units fromDate:today];
 NSInteger day = [dateComponents day];
 NSInteger weekday = [dateComponents weekday];
 NSInteger month = [dateComponents month];
 
 NSInteger weeknum = day/7;
 NSLog(@"weekday: %d, weeknum: %d, month: %d", weekday, weeknum, month);
 
 NSMutableArray *thisMonth = [months objectAtIndex:month-1];
 NSValue *v = [thisMonth objectAtIndex:((weeknum*7)+weekday-1)];
 CGPoint p = [v CGPointValue];
 NSLog(@"x: %f, y: %f", p.x, p.y);
 
 //Fill in today's cell
 int highlight = 7;
 CGContextRef context = UIGraphicsGetCurrentContext();
 CGContextSetLineWidth(context, highlight);
 CGContextSetStrokeColorWithColor(context, 
 [UIColor redColor].CGColor);
 CGRect todayRectangle = CGRectMake(p.x,p.y-(highlight/2),cellWidth/7,(cellHeight-labelHeight)/6);
 CGContextAddRect(context, todayRectangle);
 CGContextStrokePath(context);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}


@end
