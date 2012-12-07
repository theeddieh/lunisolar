//
//  Week.h
//  Lunisolar
//
//  Created by Haley Smith on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Week : NSObject{
    
   	int weekNumber;
    @public
   	NSMutableArray *days;
}

- (id) initWithParams:(int)weekNumber;
@end
