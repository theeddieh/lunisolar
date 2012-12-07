//
//  Calendar.h
//  Lunisolar
//
//  Created by Haley Smith on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"

@interface Calendar : NSObject{
    
    // this is where the class variables go
    @public
    NSMutableArray *weeks;
    NSNumber *year;
}

- (id) initWithYear:(NSNumber *)year;
//- (id) initWithSampleYear;
+ (void) populateCalendar:(NSMutableArray *) weeks currentYear:(NSNumber *)year;

@end
