//
//  GregorianCalendar.h
//  Lunisolar
//
//  Created by Haley Smith on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IslamicCalendar.h"
#import "Day.h"

@interface GregorianCalendar : NSObject
   
/* CONSTANTS */

extern int const
    JANUARY,
    FEBRUARY,
    MARCH,
    APRIL,
    MAY,
    JUNE,
    JULY,
    AUGUST,
    SEPTEMBER,
    OCTOBER,
    NOVEMBER,
    DECEMBER;

/* FUNCTIONS */

-(int) fixedDateFromGregorian:(Day *)gDate;

-(Day *) gregorianFromFixedDate:(int)rd;

-(void) correctDate:(Day *)d;

-(int) yearFromFixedDate:(int)rd;

-(BOOL) isLeapYear:(int)year;

-(int) firstDayOfMonth:(int)month year:(int)year;

-(int) numberOfDaysInMonth:(int)month year:(int)year;

-(Day *) startWeekOfMonth:(int)month year:(int)year;

-(int) numberOfWeeksInMonth:(int)month year:(int)year;

-(int) dayOfWeekFromFixedDate:(Day *)gDate;

-(NSArray *) fullYear:(int)year;

-(void) mergeHolidays:(NSArray *)yearCal holidayCal:(NSArray *)holidayCal;

-(NSArray *) getHolidays:(int)year;

-(Day *) holidayEaster:(int)year;

-(Day *) holidayAshWednesday:(Day *)easter;

-(Day *) holidayPalmSunday:(Day *)easter;

-(Day *) holidayAllSaintsDay:(int)year;

-(Day *) holidayChristams:(int)year;


@end
