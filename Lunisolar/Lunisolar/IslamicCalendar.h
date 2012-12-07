//
//  IslamicCalendar.h
//  Lunisolar
//
//  Created by  on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"
#import "GregorianCalendar.h"

@interface IslamicCalendar : NSObject

/* CONSTANTS */

extern int const
    MUHARRAM,
    SAFAR,
    RABI_I,
    RABI_II,
    JAMADA_I,
    JAMADA_II,
    RAJAB,
    SHABAN,
    RAMADAN,
    SHAWWAL,
    DHUALQADA,
    DHUALHIJJA;

extern int const ISLAMIC_EPOCH;

/* FUNCTIONS */

-(BOOL) isLeapYear:(int)iyear;

-(int) fixedFromIslamic:(Day *)idate;

-(Day *) islamicFomFixed:(int)rd;

-(NSArray *) getHolidays:(int)year;

-(NSArray *) holidayRamadan:(int)year;

-(NSArray *) holidayIslamicNewYear:(int)year;

-(NSArray *) holidayAshura:(int)year;

-(NSArray *) holidayMawlidAnNabi:(int)year;

-(NSArray *) holidayAscentOfTheProphet:(int)year;

-(NSArray *) holidayLailatAlKadr:(int)year;

-(NSArray *) holidayLailatAlBaraa:(int)year;

-(NSArray *) holidayIdAlFitr:(int)year;

-(NSArray *) holidayIdAlAdha:(int)year;

@end
