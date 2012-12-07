//
//  CircularYear.m
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  CoreText tutorial from http://invasivecode.tumblr.com/core-text

#import "CircularYearView.h"
#import "GregorianCalendar.h"
#import "Day.h"

@implementation CircularYearView

@synthesize attString;

@synthesize yearField;

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
    [super drawRect:rect];
    
    //Determine circle dimentions 
    decrement = 50; //ONLY USE EVEN NUMBERS
    totalSize = 740; //Adjust to resize object
    radius = totalSize/2;
    rings = 8;
    
    int width = self.bounds.size.width;
    offset = (width/2) - radius;
    cellHeight = decrement/2;
    center = CGPointMake(offset+(totalSize/2), offset+(totalSize/2));
  
    [self drawYear:[self year]];

}

- (void)drawYear:(int)year
{
    //Drop all previous subviews, ie labels
    for (UIView *view in self.subviews) {
        if ([view tag] == 100){
            [view removeFromSuperview];
        }
    }
    
    //Initialize calendar colors
    UIColor *springColor = [UIColor colorWithRed:0.996 green:0.792 blue:0.357 alpha:0.5];
    UIColor *summerColor = [UIColor colorWithRed:0.9098 green:0.478 blue:0.263 alpha:0.5];
    UIColor *fallColor = [UIColor colorWithRed:0.49 green:0.55 blue:0.93 alpha:0.5];
    UIColor *winterColor = [UIColor colorWithRed:0.718 green:0.969 blue:0.553 alpha:0.5];
    
    UIColor *gregorianColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:0.65];
    UIColor *hebrewColor =  [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:0.65];
    UIColor *islamColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.65];
    UIColor *americanColor = [UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:0.65];
    
    
    //Determine today's date and initialize calendar to current year
    NSDate *today = [NSDate date];
    unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:units fromDate:today];
    NSInteger day = [dateComponents day];
    NSInteger month = [dateComponents month];
    NSInteger currentYear = [dateComponents year];
        
    //Get year from Eddie's fuctions
     id cal = [[GregorianCalendar alloc] init];
    NSArray * days = [cal fullYear:[self year]];
    Day * d;
    
    weeks = 53;
    
    //Set up context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    yearField.placeholder = [NSString stringWithFormat:@"%d", [self year]];


    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, self.bounds.size.width/2, totalSize/2 + offset);
    
    CGContextSetLineWidth(context, cellHeight/2);
    for (int i = 0; i < 4; i++){
        if (i == 0)
            CGContextSetStrokeColorWithColor(context, winterColor.CGColor);
        else if (i == 1)
            CGContextSetStrokeColorWithColor(context, springColor.CGColor);
        else if (i == 2)
            CGContextSetStrokeColorWithColor(context, summerColor.CGColor);
        else 
            CGContextSetStrokeColorWithColor(context, fallColor.CGColor);
        
        CGContextAddArc(context, 0, 0, (decrement/8)+radius-(cellHeight*(0)), i * M_PI_2, (i+1) * M_PI_2, 0);
        CGContextStrokePath(context);
    }
    
    //  Make Labels on angles using CoreText
    //
    //  CoreText uses an inverse coord from quartz
    //  flipping coordinate system
    
    //add rotation of 90 degrees counterclockwise
    CGContextRotateCTM(context, -M_PI_2); 
    
    //add offset for solstices
    CGContextRotateCTM(context,-((51/weeks)*360)* M_PI / 180); 

    
    //color days 
    double h = 360/weeks;
    CGContextSetLineWidth(context, cellHeight);
    for (int j = 0; j < rings-1; j++){
        int i;
        for (i = 0; i < weeks + 1; i++){
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            if (j+(i*7) < [days count]){
                d = [days objectAtIndex:j+(i*7)];
                
                //color days that are not in the year black
                if ([d year] != [self year]){
                    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
                } 
                //paint today blue
                else if ([d year] == currentYear && [d month] == month && [d day] == day){
                    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
                } 
                //Alternate coloring months white and grey
                else if ([d month] % 2 == 0){
                    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
                    
//                    //if it is a weekend, make it a little darker
//                    if (j == 0 || j == rings - 2){
//                        CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
//                    }
                     
                } 
                else{ 
                    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
                    
//                    if (j == 0 || j == rings - 2){
//                        CGContextSetStrokeColorWithColor(context, [UIColor darkGrayColor].CGColor);
//                    }
                     
                }
        
            } else{
                CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
            }
            
            //I dont know why but this radius calculation works
            //          (decrement/4): lines up everything with the lines that I created previously
            //          (cellHeight*(j+2)): which ring of days (Monday, Tuesday, Wednesday, etc) is it
            CGContextAddArc(context, 0, 0, (decrement/4)+radius-(cellHeight*(j+2)), (i*h) * M_PI / 180, ((i*h)+h) * M_PI / 180, 0);
            
            
            CGContextStrokePath(context);
        }
    }
    
    //color holidaysdays 
    double q;
    BOOL gregorian, hebrew, islam, american;
    int holidays;

    NSMutableArray * holidaylabels = [[NSMutableArray alloc] init];
    CGContextSetLineWidth(context, cellHeight);
    for (int j = 0; j < rings-1; j++){
        for (int i = 0; i < weeks + 1; i++){
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            q = h;
            if (j+(i*7) < [days count]){
                d = [days objectAtIndex:j+(i*7)];
                gregorian = false;
                islam = false; 
                hebrew = false;
                american = false;
                holidays = 0;
                // loop through linked list of days looking at holidays and find out how many are on this day
                if ([d nextDay] != NULL && [d year] == [self year]){
                    
                    for (Day *walker = d; walker != NULL; walker = [walker nextDay]){
                        // GREGORIAN
                        if ([[walker calendar] isEqualToString:@"Gregorian"]) {
                            if ([self  showGregorian]){
                                gregorian = true;
                                holidays++;
                                
                                if([self showLabels]) {
                                    [self makeLabel:i j:j h:h walker:walker holidaylabels:holidaylabels];
                                }
                            }
                        }
                        // AMERICAN
                        if ([[walker calendar] isEqualToString:@"American"]) {
                            if ([self  showHindu]){
                                american = true;
                                holidays++;
                                
                                if([self showLabels]) {
                                    [self makeLabel:i j:j h:h walker:walker holidaylabels:holidaylabels];
                                }
                            }
                        }
                        // HEBREW
                        if ([[walker calendar] isEqualToString:@"Hebrew"]) {
                            if ([self  showHebrew]){
                                hebrew = true;
                                holidays++;
                                
                                if([self showLabels]) {
                                    [self makeLabel:i j:j h:h walker:walker holidaylabels:holidaylabels];
                                }
                            }
                        }
                        
                        // ISLAMIC
                        if ([[walker calendar] isEqualToString:@"Islamic"]) {
                            if ([self  showIslamic]){
                                islam = true;
                                holidays++;
                                
                                if([self showLabels]) {
                                    [self makeLabel:i j:j h:h walker:walker holidaylabels:holidaylabels];
                                }
                            }
                        } 
                    }
                }
            }
            //then paint portion of the day depending on number of holidays
            if (gregorian || islam || hebrew || american){
                
                q = h/holidays;
                for (int p = 0; p < holidays; p++){
                    if (gregorian){
                        CGContextSetStrokeColorWithColor(context, gregorianColor.CGColor);
                        gregorian = false;

                    } else if (hebrew){
                        CGContextSetStrokeColorWithColor(context, hebrewColor.CGColor);
                        hebrew = false;

                    } else if (islam){
                        CGContextSetStrokeColorWithColor(context, islamColor.CGColor);
                        islam = false;

                    } else if (american){
                        CGContextSetStrokeColorWithColor(context, americanColor.CGColor);
                        american = false;
                        
                    }
                    //I dont know why but this radius calculation works
                    //          (decrement/4): lines up everything with the lines that I created previously
                    //          (cellHeight*(j+2)): which ring of days (Monday, Tuesday, Wednesday, etc) is it
                    CGContextAddArc(context, 0, 0, (decrement/4)+radius-(cellHeight*(j+2)), ((i*h)+(p*q)) * M_PI / 180, (((i*h)+(p*q))+q) * M_PI / 180, 0);
                    CGContextStrokePath(context);
                }
            }
        }
    }
    
    CGContextScaleCTM(context, 1.0, -1.0); 
    CGContextRotateCTM(context, -M_PI_2);
    
    //create attributes for string
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"Times", 12, NULL);
    NSDictionary *attrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)fontRef, (NSString *)kCTFontAttributeName,  nil];
    CFRelease(fontRef);
    
    
    //number days, I dont know why I cant number and color days at the same time
    for (int j = 0; j < rings-1; j++){
        for (int i = 0; i < weeks*2; i++){
            if ( j+(i*7) < [days count] ){
                CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
                
                d = [days objectAtIndex:j+(i*7)];
                attString=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %d ", [d day]] attributes:attrDictionary];
                if ([d year] != [self year]){
                    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
                }
                [self markday:j+1 dev:weeks/2];
                
            } else {
                CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
                attString=[[NSAttributedString alloc] initWithString:@"0" attributes:attrDictionary];
                [self markday:j+1 dev:weeks/2]; 
                
            }
        }
    }

    
    //make array of month label all 9 characters long
    NSArray *labels = [NSArray arrayWithObjects:@" January ", @" February ", @"   March   ", @"   April   ", @"    May    ", @"   June    ", @"   July   ", @"   August   ", @" September ", @" October ", @" November ", @" December ", nil];
    
    //modify attribute string for month labels
    fontRef = CTFontCreateWithName((CFStringRef)@"Times", 24, NULL);
    attrDictionary = [NSDictionary dictionaryWithObjectsAndKeys:(__bridge id)fontRef, (NSString *)kCTFontAttributeName,  nil];
    CFRelease(fontRef);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    
    //draw month labels one at a time
    if ([cal firstDayOfMonth:0 year:[self year]] != 6){
        attString=[[NSAttributedString alloc] initWithString:@" " attributes:attrDictionary];
        [self markday:0 dev:(weeks/2)/1]; 
    }
    int p;
    for (int i = 0; i < 12; i++){
        p = [cal numberOfWeeksInMonth:i+1 year:[self year]];
        attString=[[NSAttributedString alloc] initWithString:[labels objectAtIndex:i] attributes:attrDictionary];
        
        if ([cal firstDayOfMonth:i+1 year:[self year]] == 1){
            [self markday:0 dev:(weeks/2)/p]; 
            
        } else{
            [self markday:0 dev:(weeks/2)/(p-1)]; 
            
        }
    }
}

- (void)makeLabel:(int)i j:(int)j h:(double)h walker:(Day *)walker holidaylabels:(NSMutableArray *)holidaylabels{
    
    //x = cx + r * cos(a)
    //y = cy + r * sin(a)
    double a = ((i*h)* M_PI / 180) - (((90)* M_PI / 180) + (((51/weeks)*360)* M_PI / 180));
    //double a = ((i*h)* M_PI / 180) - (((90)* M_PI / 180));
    
    BOOL t = true;
    NSLog(@"month %d, date %d, holiday %@", [walker month], [walker day], [walker name]);
    for (NSString *s in holidaylabels){
        if ([[walker name] isEqualToString:s]){
            t = false;
        }
    }
    
    if (t){
        CGRect labelFrame = CGRectMake( center.x + (((decrement/4)+radius-(cellHeight*(j+2))) * cos(a)), center.y + (((decrement/4)+radius-(cellHeight*(j+2))) * sin(a)), 200, 30);
        UILabel* label = [[UILabel alloc] initWithFrame: labelFrame];
        [label setText:[walker name]];
        [holidaylabels addObject:[walker name]];
        [label setTextColor: [UIColor whiteColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        label.font = [UIFont boldSystemFontOfSize:20];
        label.tag = 100;
        
        [label setShadowColor:[UIColor blackColor]];
        label.shadowOffset = CGSizeMake(2,2);
        label.clipsToBounds = NO;
        
        
        [self addSubview: label];
    }
    

}

- (void)markday:(NSInteger)dof dev:(double)dev{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0, [UIColor whiteColor].CGColor);
    
    //create text line from attribute string
    CTLineRef line = CTLineCreateWithAttributedString((__bridge CFAttributedStringRef)attString);
    
    //Count characters, glyphs and runs
    CFIndex glyphCount = CTLineGetGlyphCount(line);
    CFArrayRef runArray = CTLineGetGlyphRuns(line);
    CFIndex runCount = CFArrayGetCount(runArray); 
    
    //create array of glyphs, store widths
    NSMutableArray *widthArray = [[NSMutableArray alloc] init];
    CFIndex glyphOffset = 0;
    for (CFIndex i = 0; i < runCount; i++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, i);
        CFIndex runGlyphCount = CTRunGetGlyphCount((CTRunRef)run);
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < runGlyphCount; runGlyphIndex++) {
            NSNumber *widthValue = [NSNumber numberWithDouble:CTRunGetTypographicBounds((CTRunRef)run, CFRangeMake(runGlyphIndex, 1), NULL, NULL, NULL)];
            [widthArray insertObject:widthValue atIndex:(runGlyphIndex + glyphOffset)];
        }
        glyphOffset = runGlyphCount + 1;
    }
    
    //calculate angles
    CGFloat lineLength = CTLineGetTypographicBounds(line, NULL, NULL, NULL);
    NSMutableArray *angleArray = [[NSMutableArray alloc] init];
    CGFloat prevHalfWidth =  [[widthArray objectAtIndex:0] floatValue] / 2.0;
    
    NSNumber *angleValue = [NSNumber numberWithDouble:(prevHalfWidth / lineLength) * (M_PI/(dev/2))]; //should be half of other angleValue
    [angleArray insertObject:angleValue atIndex:0];
    
    for (CFIndex lineGlyphIndex = 1; lineGlyphIndex < glyphCount; lineGlyphIndex++) {
        CGFloat halfWidth = [[widthArray objectAtIndex:lineGlyphIndex] floatValue] / 2.0;
        CGFloat prevCenterToCenter = prevHalfWidth + halfWidth;

        NSNumber *angleValue = [NSNumber numberWithDouble:(prevCenterToCenter / lineLength) * (M_PI/dev)]; // adjust M_PI value for pie slice angle
        [angleArray insertObject:angleValue atIndex:lineGlyphIndex];
        prevHalfWidth = halfWidth;
    }
    
    //drawing the charters, hard-coded center point
    int dec = decrement/2;
    CGPoint textPosition = CGPointMake(0,  (5)+(totalSize/2-(dec*(dof+1))));
    CGContextSetTextPosition(context, textPosition.x, textPosition.y);
    
    glyphOffset = 0;
    for (CFIndex runIndex = 0; runIndex < runCount; runIndex++) {
        CTRunRef run = (CTRunRef)CFArrayGetValueAtIndex(runArray, runIndex);
        CFIndex runGlyphCount = CTRunGetGlyphCount(run);
        CTFontRef runFont = CFDictionaryGetValue(CTRunGetAttributes(run), kCTFontAttributeName);
        for (CFIndex runGlyphIndex = 0; runGlyphIndex < runGlyphCount; runGlyphIndex++) {
            
            CFRange glyphRange = CFRangeMake(runGlyphIndex, 1);
            
            CGContextRotateCTM(context, -[[angleArray objectAtIndex:(runGlyphIndex + glyphOffset)] floatValue]);
            
            CGFloat glyphWidth = [[widthArray objectAtIndex:(runGlyphIndex + glyphOffset)] floatValue];
            CGFloat halfGlyphWidth = glyphWidth / 2.0;
            CGPoint positionForThisGlyph = CGPointMake(textPosition.x - halfGlyphWidth, textPosition.y);
            
            textPosition.x -= glyphWidth;
            
            CGAffineTransform textMatrix = CTRunGetTextMatrix(run);
            textMatrix.tx = positionForThisGlyph.x; textMatrix.ty = positionForThisGlyph.y;
            CGContextSetTextMatrix(context, textMatrix);
            
            CGFontRef cgFont = CTFontCopyGraphicsFont(runFont, NULL);
            CGGlyph glyph; CGPoint position;
            CTRunGetGlyphs(run, glyphRange, &glyph);
            CTRunGetPositions(run, glyphRange, &position);
            
            CGContextSetFont(context, cgFont);
            CGContextSetFontSize(context, CTFontGetSize(runFont));
                        
            CGContextShowGlyphsAtPositions(context, &glyph, &position, 1);
            
            CFRelease(cgFont);
        }
        glyphOffset += runGlyphCount;
    }
    
    
    CFRelease(line);
}

- (int)year {
    if (year == 0) {
        NSDate *today = [NSDate date];
        unsigned units = NSYearCalendarUnit;
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *dateComponents = [calendar components:units fromDate:today];
        year = [dateComponents year];
    }
    return year;
}

- (void)setYear:(int)newValue {
    year = newValue;
}

- (BOOL)showGregorian {
    return showGregorian;
}

- (void)setShowGregorian:(BOOL)newValue {
    showGregorian = newValue;
}

- (BOOL)showHebrew {
    return showHebrew;
}

- (void)setShowHebrew:(BOOL)newValue {
    showHebrew = newValue;
}

- (BOOL)showIslamic {
    return showIslamic;
}

- (void)setShowIslamic:(BOOL)newValue {
    showIslamic = newValue;
}

- (BOOL)showAmerican {
    return showAmerican;
}

- (void)setShowAmerican:(BOOL)newValue {
    showAmerican = newValue;
}

- (BOOL)showHindu {
    return showHindu;
}

- (void)setShowHindu:(BOOL)newValue {
    showHindu = newValue;
}

- (BOOL)showChinese {
    return showChinese;
}

- (void)setShowChinese:(BOOL)newValue {
    showChinese = newValue;
}

- (BOOL)showLunar {
    return showLunar;
}

- (void)setShowLunar:(BOOL)newValue {
    showLunar = newValue;
}

- (BOOL)showLabels {
    return showLabels;
}

- (void)setShowLabels:(BOOL)newValue {
    showLabels = newValue;
}

@end