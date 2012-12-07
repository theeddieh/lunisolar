//
//  CircularYear.m
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CircularYear.h"

@implementation CircularYear

@synthesize attString;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  /*  
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext(); // 1-1
    
    // Flip the coordinate system
    CGContextSetTextMatrix(context, CGAffineTransformIdentity); // 2-1
    CGContextTranslateCTM(context, 0, self.bounds.size.height); // 3-1
    CGContextScaleCTM(context, 1.0, -1.0); // 4-1
    
    CGMutablePathRef path = CGPathCreateMutable(); // 5-2
    CGPathAddRect(path, NULL, CGRectMake(200.0, 300.0, 400.0, 600.0)); // 6-2
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attString); // 7-2
    CTFrameRef theFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL); // 8-2
    CFRelease(framesetter); // 9-2
    CFRelease(path); // 10-2
    
    CTFrameDraw(theFrame, context); // 11-2
    CFRelease(theFrame); // 12-2
*/
    
    /****************WRITTEN BY JAMES*********************/
    
    //Setting up context for drawing circles and lines
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    offset = 10;
    decrement = 60; //ONLY USE EVEN NUMBERS
    totalSize = 750; //Adjust to resize object
    rings = 8;
    
    int start, size;
    
    //Draw rings
    for (int i = 0; i <= rings; i++){
        
        start = i * (decrement/2);
        size = totalSize - (i * decrement);
        
        CGRect rectangle = CGRectMake(offset + start, offset + start, size, size);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
        if (i == rings){
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
        } else {
            CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        }
        CGContextFillEllipseInRect(context, rectangle);
        
    }
    
    //Draw Months
    CGPoint point, point2;
    for (double j = 0; j < 360; j = j + 30){
        
        //x = cx + r * cos(a)
        //y = cy + r * sin(a)
        
        //Default cos() and sin() uses radians, must convert degrees to radians
        double radians = j * M_PI / 180;
        
        point.x = (totalSize/2 + offset) + ((totalSize/2) * cos(radians));
        point.y = (totalSize/2 + offset) + ((totalSize/2) * sin(radians));
        
        point2.x = (totalSize/2 + offset) + (((totalSize/2) - (rings * (decrement/2))) * cos(radians));
        point2.y = (totalSize/2 + offset) + (((totalSize/2) - (rings * (decrement/2))) * sin(radians));
        
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        
        if (j == 60){
            //CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
            //CGContextFillPath(context);
        }
        
        NSLog(@"%f, %f", point.x, point.y);
    }
    
    
    //Draw Days
    CGPoint point3, point4;
    for (double j = 0; j < 360; j = j + 6){
        
        //x = cx + r * cos(a)
        //y = cy + r * sin(a)
        
        //Default cos() and sin() uses radians, must convert degrees to radians
        double radians = j * M_PI / 180;
        
        point3.x = (totalSize/2 + offset) + (((totalSize/2) - (1 * (decrement/2))) * cos(radians));
        point3.y = (totalSize/2 + offset) + (((totalSize/2) - (1 * (decrement/2))) * sin(radians));
        
        point4.x = (totalSize/2 + offset) + (((totalSize/2) - (rings * (decrement/2))) * cos(radians));
        point4.y = (totalSize/2 + offset) + (((totalSize/2) - (rings * (decrement/2))) * sin(radians));
        
        CGContextMoveToPoint(context, point3.x, point3.y);
        CGContextAddLineToPoint(context, point4.x, point4.y);
        
        NSLog(@"%f, %f", point3.x, point3.y);
    }
    
    
    CGContextStrokePath(context);
    
    /****************END OF WHAT WAS WRITTEN BY JAMES*********************/
}

@end