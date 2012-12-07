//
//  Month.m
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Month.h"

@implementation Month

int indent = 7;
int lineSize = 1;

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
    // Drawing basic month calender
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float cellWidth = width/7;
    float cellHeight = height/7;//+1
    NSLog(@"width: %f, height: %f, cellWidth: %f, cellHeight: %f", width, height, cellWidth, cellHeight);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //draw square outline
    CGContextSetLineWidth(context, lineSize);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextMoveToPoint(context, indent, indent);
    CGContextAddLineToPoint(context, indent, cellHeight - indent);
    
    CGContextMoveToPoint(context, indent, indent);
    CGContextAddLineToPoint(context, width-indent, indent);
    
    CGContextMoveToPoint(context, indent, cellHeight - indent);
    CGContextAddLineToPoint(context, width - indent, cellHeight - indent);
    
    CGContextMoveToPoint(context, width-indent, indent);
    CGContextAddLineToPoint(context, width-indent, cellHeight - indent);
    CGContextStrokePath(context);
    
    //draw grid
    NSMutableArray * cells = [Month drawGrid:width height:height-cellHeight x:0 y:cellHeight];
    
    //TODO: if year and month are current, mark current day
    //determine today's cell
    NSDate *today = [NSDate date];
    unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:units fromDate:today];
    NSInteger day = [dateComponents day];
    NSInteger weekday = [dateComponents weekday];
    NSInteger month = [dateComponents month];
    
    NSInteger weeknum = day/7; //height
    NSLog(@"weekday: %d, weeknum: %d, month: %d", weekday, weeknum, month);
    
    NSValue *v = [cells objectAtIndex:((weeknum*7)+weekday-1)];
    CGPoint p = [v CGPointValue];
    
    //fill in today's cell
    int highlight = 8;
    CGContextSetLineWidth(context, highlight);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect todayRectangle;
    if (weeknum == 0 || weeknum == 1 || weeknum == 2){
        todayRectangle = CGRectMake(p.x-(highlight/2),p.y-(highlight/2) + indent ,cellWidth,cellHeight);
    } else {
        todayRectangle = CGRectMake(p.x-(highlight/2),p.y-(highlight/2),cellWidth,cellHeight);
    }
    CGContextAddRect(context, todayRectangle);
    CGContextFillPath(context);
    CGContextStrokePath(context);
    
     
    //fill in month label
    NSArray *labels = [NSArray arrayWithObjects:@"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December", nil];
    UIFont *font =  [UIFont systemFontOfSize:100.0];
    NSString *label = [labels objectAtIndex:month-1];
    [label drawInRect:CGRectMake(0, indent+3, width, cellHeight) withFont:font lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
    
}

+ (NSMutableArray *)drawGrid:(float)width height:(float)height x:(CGFloat)x y:(CGFloat)y
{
    float cellWidth = (width-(indent*2))/7.0;
    float cellHeight = (height-(indent*2))/6.0;
    
    // building cell array
    NSMutableArray *cells = [Month buildCells:width height:height x:x y:y widthDev:7 heightDev:6];
    for (NSValue* val in cells) {
        CGPoint p = [val CGPointValue];
        //NSLog(@"%.0f, %.0f", p.x, p.y);
        
    }
    
    // drawing calendar background
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // draw borders
    CGContextSetLineWidth(context, lineSize);
    CGContextSetStrokeColorWithColor(context, [UIColor
                                               darkGrayColor].CGColor);
    CGContextMoveToPoint(context, x+indent, y);
    CGContextAddLineToPoint(context, x+indent, y + height-indent);
    
    CGContextMoveToPoint(context, x+indent, y);
    CGContextAddLineToPoint(context, x + width-indent, y);
    
    CGContextMoveToPoint(context, x+indent, y+ height-indent);
    CGContextAddLineToPoint(context, x + width-indent, y+ height -indent);
    
    CGContextMoveToPoint(context, x+ width-indent, y);
    CGContextAddLineToPoint(context, x + width-indent, y+ height -indent);
    CGContextStrokePath(context);
    
    
    //Drawing calendar grid
    CGContextSetLineWidth(context, lineSize);
    CGContextSetStrokeColorWithColor(context, [UIColor
                                               purpleColor].CGColor);
    
    for (int i = 1; i < 7; i++){
        CGContextMoveToPoint(context, x + (cellWidth*i)+indent, y);
        CGContextAddLineToPoint(context, x + (cellWidth*i)+indent, y + height-indent); 
        
    }
    CGContextStrokePath(context);
    
    for (int i = 1; i < 6; i++){
        CGContextMoveToPoint(context, x+indent, y + (cellHeight*i)+indent);
        CGContextAddLineToPoint(context, x + width-indent, y + (cellHeight*i)+indent);
    }
    CGContextStrokePath(context);
    
    return cells;
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
            
            
            // put label in cell
            if (heightDev == 6){ //if drawing days, not months
                
                UIFont *font =  [UIFont systemFontOfSize:12.0];
                [@"01" drawInRect:CGRectMake(temp.x + 10 - j , temp.y + 4 - i, cellWidth - 10, cellHeight - 4) withFont:font];
                
            }
        }
    }
    
    return cells;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end

