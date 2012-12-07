//
//  Week.m
//  Lunisolar
//
//  Created by Haley Smith on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Week.h"
#import "Day.h"

@implementation Week

- (id) initWithParams:(int)weekNumber {

	self = [super init];

	if (self){
        self->weekNumber = weekNumber;
	}
    
    days = [[NSMutableArray alloc] initWithCapacity:7];
    
	return self;
}
@end
