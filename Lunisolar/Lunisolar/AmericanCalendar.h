//
//  AmericanCalendar.h
//  Lunisolar
//
//  Created by  on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GregorianCalendar.h"
#import "Day.h"

@interface AmericanCalendar : NSObject

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

-(NSArray *) getHolidays:(int)year;

-(Day *) holidayNewYearsDay:(int)year; 

-(Day *) holidayMLKDay:(int)year;

-(Day *) holidayGroundhogDay:(int)year;

-(Day *) holidayValentinesDay:(int)year;

-(Day *) holidayLeapDay:(int)year;

-(Day *) holidayIdesOfMarch:(int)year;

-(Day *) holidayAprilFoolsDay:(int)year;

-(Day *) holidayMemorialDay:(int)year;

-(Day *) holiday4thOfJulyDay:(int)year;

-(Day *) holidayLaborDay:(int)year;

-(Day *) holidayHalloween:(int)year;

-(Day *) holidayThanksgiving:(int)year;

-(Day *) holidayNewYearsEve:(int)year;



@end
