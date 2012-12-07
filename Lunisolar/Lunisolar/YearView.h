//
//  Year.h
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface YearView : UIView {
    
    int currentYear;
}

- (void)drawYear:(int)year;

- (int)currentYear;

- (void)setCurrentYear:(int)newValue;

@end
