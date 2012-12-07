//
//  Month.h
//  Lunisolar
//
//  Created by James Atherton Kent on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface Month : UIView

+ (NSArray*)buildCells:(float)width height:(float)height x:(CGFloat)x y:(CGFloat)y widthDev:(int)widthDev heightDev:(int)heightDev;

+ (NSMutableArray *)drawGrid:(float)width height:(float)height x:(CGFloat)x y:(CGFloat)y;

@end
