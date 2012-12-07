//
//  HebrewCalendar.h
//  Lunisolar
//
//  Created by James Atherton Kent on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Day.h"
#import "GregorianCalendar.h"


@interface HebrewCalendar : NSObject

/* CONSTANTS */

extern int const
    NISAN,
    IYYAR,
    SIVAN,
    TAMMUZ,
    AV,
    ELUL,
    TISHRI,
    HESHVAN,
    KISLEV,
    TEVETH,
    SHEVAT,
    ADAR_I,
    ADAR_II;

extern int const EPOCH_RD;

/* FUNCTIONS */

-(int) fixedDateFromHebrew:(Day *)hDay;

-(int) hebrewFromFixedDate:(Day *)hDay:(int)year;

-(int) daysElapsedFromEpochToStartOfYear:(int)year;

-(int) daysInYear:(int)year;

-(BOOL) isLeapYear:(int)year;

-(int) newYearDelay:(int)year;

-(int) numberOfMonthsInYear:(int)year;

-(int) lastDayOfMonth:(int)month year:(int)year; 

-(BOOL) longHeshvan:(int)year;

-(BOOL) shortKislev:(int)year;

- (NSArray *) getHolidays:(int)year;

-(Day *) holidayYomKippur:(int)year;

-(Day *) holidayRoshHaShanah:(int)year;

-(Day *) holidaySukkot:(int)year;

-(Day *) holidayHoshanaRabba:(int)year;

-(Day *) holidaySheminiAzereth:(int)year;

-(Day *) holidaySimhatTorah:(int)year;

-(NSArray *) holidayHanukkah:(int)year;

-(Day *) holidayHanukkah1:(int)year;
-(Day *) holidayHanukkah2:(int)year;
-(Day *) holidayHanukkah3:(int)year;
-(Day *) holidayHanukkah4:(int)year;
-(Day *) holidayHanukkah5:(int)year;
-(Day *) holidayHanukkah6:(int)year;
-(Day *) holidayHanukkah7:(int)year;
-(Day *) holidayHanukkah8:(int)year;

-(Day *) holidayTuBShevat:(int)year;

-(Day *) holidayPurim:(int)year;

-(Day *) holidayPassover:(int)year;

-(Day *) holidayEndingOfPassover:(int)year;

-(Day *) holidayShavuot:(int)year;




@end
