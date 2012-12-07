//
//  CircularYear.h
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface CircularYear : UIView{
    NSAttributedString *attString;
    
    int decrement; //ONLY USE EVEN NUMBERS
    int totalSize; //Adjust to resize object
    int rings;
    int offset;
}

@property (nonatomic, retain) IBOutlet NSAttributedString *attString;

@end
