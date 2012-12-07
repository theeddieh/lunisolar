//
//  HebrewCalendar.m
//  Lunisolar
//
//  Created by James Atherton Kent on 4/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HebrewCalendar.h"
#import "GregorianCalendar.h"

#import "Day.h"


@implementation HebrewCalendar

/* CONSTANTS */

int const
    NISAN = 1,
    IYYAR = 2,
    SIVAN = 3,
    TAMMUZ = 4,
    AV = 5,
    ELUL = 6,
    TISHRI = 7,
    HESHVAN = 8,
    KISLEV = 9,
    TEVETH = 10,
    SHEVAT = 11,
    ADAR_I = 12,
    ADAR_II = 13;

int const EPOCH_RD = -1373427;
/* FUNCTIONS */

// Returns R.D. date based on Hebrew date
-(int) fixedDateFromHebrew:(Day *)hDay
{
    int numberOfDays = -1373427 + [self daysElapsedFromEpochToStartOfYear:[hDay year]] + [self newYearDelay:[hDay year]] - 1;
    
    if ([hDay month] < 7)
    {
        for (int i = 7; i < [self numberOfMonthsInYear:[hDay year]]; i++)
        {
            numberOfDays = numberOfDays + [self lastDayOfMonth:i year:[hDay year]];
        }
        for (int i = 1; i < [hDay month]; i++)
        {
            numberOfDays = numberOfDays + [self lastDayOfMonth:i year:[hDay year]];
        }
    }
    else
    {
        for (int i = 7; i < [hDay month]; i++)
        {
            [self lastDayOfMonth:i year:[hDay year]];
        }
    }
    
    numberOfDays = numberOfDays + [hDay day];
        
    //NSLog(@"RD: %d.", numberOfDays);
    
    return numberOfDays;
    
}

//Returns a fixed date that is the first Hebrew date of th first of the year
-(int) hebrewFromFixedDate:(Day *)hDay:(int)year
{
    //int fixedDate = [GregorianCalendar fixedDateFromGregorian:[Day dayInit:1 month:1 year:year]];

    return 0;
}

// Returns number of days from the start of the Hebrew calendar to the first of the current year
-(int) daysElapsedFromEpochToStartOfYear:(int)year
{    
    int monthsElapsed = (235 * year - 234) / 19;
    int partsElapsed = 13753 * monthsElapsed + 12084;
    int days = 29 * monthsElapsed + (partsElapsed / 25920);
    
    if ( (3 * (days + 1)) % 7 < 3)
    {
       return days + 1;
    }
    else 
    {
        return days;
    }
}

// Returns number of days in the given year
-(int) daysInYear:(int)year
{
    int upToNextYear = [self daysElapsedFromEpochToStartOfYear:year + 1] + [self newYearDelay:year + 1];
    int upToThisYear = [self daysElapsedFromEpochToStartOfYear:year] + [self newYearDelay:year];
    
    return upToNextYear - upToThisYear;
}

// Check is the year is a leap year
// Leap Years occur on the 3rd, 6th, 8th, 11th, 14th, 17th, and 19th years of the 19-year cycle
-(BOOL) isLeapYear:(int)year
{
    return ( ((7 * year) % 19) < 7 );
}

// Returns how long the New Years delay is
-(int) newYearDelay:(int)year
{
    int lastYear = [self daysElapsedFromEpochToStartOfYear:year - 1];
    int thisYear = [self daysElapsedFromEpochToStartOfYear:year];
    int nextYear = [self daysElapsedFromEpochToStartOfYear:year + 1];
    
    if (nextYear - thisYear == 356)
    {
        return 2;
    }
    else if (thisYear - lastYear == 382)
    {
        return 1;
    }
    else 
    {
        return 0;
    }
}

// Returns number of months in current year
-(int) numberOfMonthsInYear:(int)year
{
    if ([self isLeapYear:year])
    {
        return 13;
    }
    return 12;
}

// Returns the length of the given month
-(int) lastDayOfMonth:(int)month year:(int)year
{
    if ( (month == IYYAR) || (month == TAMMUZ) || (month == ELUL) || (month == TEVETH) || (month == ADAR_II) )
    {
        return 29;
    }
    else if ( (month == ADAR_I) && (![self isLeapYear:year]) ) 
    {
        return 29;
    }
    else if ( (month == HESHVAN) && (![self longHeshvan:year]) ) 
    {
        return 29;
    }
    else if ( (month == KISLEV) && (![self shortKislev:year]) ) 
    {
        return 29;
    }
    else 
    {
        return 30;
    }
}

// Checks if the year has a long Heshvan
-(BOOL) longHeshvan:(int)year
{
    return (([self daysInYear:year] % 10) == 3);   
}

// Checks if the year has a short Kislev
-(BOOL) shortKislev:(int)year
{
    return (([self daysInYear:year] % 10) == 5);
}

// Generates list of holidays within the given year
- (NSArray *) getHolidays:(int)year
{
    NSMutableArray *holidays = [[NSMutableArray alloc] initWithCapacity:12];
    
    //weird math hack we need
    int adjustedYear = year + 1;
    
    [holidays addObject:[self holidayRoshHaShanah:adjustedYear]];
    [holidays addObject:[self holidayYomKippur:adjustedYear]];
    [holidays addObject:[self holidaySukkot:adjustedYear]];
    [holidays addObject:[self holidayHoshanaRabba:adjustedYear]];    
    [holidays addObject:[self holidaySheminiAzereth:adjustedYear]];
    [holidays addObject:[self holidaySimhatTorah:adjustedYear]];
    
    [holidays addObject:[self holidayHanukkah1:adjustedYear]];
    
    /*
    [holidays addObjectsFromArray:[self holidayHanukkah:year]];
    
    [holidays addObject:[self holidayHanukkah1:adjustedYear]];
    [holidays addObject:[self holidayHanukkah2:adjustedYear]];
    [holidays addObject:[self holidayHanukkah3:adjustedYear]];
    [holidays addObject:[self holidayHanukkah4:adjustedYear]];
    [holidays addObject:[self holidayHanukkah5:adjustedYear]];
    [holidays addObject:[self holidayHanukkah6:adjustedYear]];
    [holidays addObject:[self holidayHanukkah7:adjustedYear]];
    [holidays addObject:[self holidayHanukkah8:adjustedYear]];
     */

    [holidays addObject:[self holidayTuBShevat:adjustedYear]];
    [holidays addObject:[self holidayPurim:adjustedYear]];
    [holidays addObject:[self holidayPassover:adjustedYear]];
    [holidays addObject:[self holidayEndingOfPassover:adjustedYear]];
    [holidays addObject:[self holidayShavuot:adjustedYear]];

    return holidays;
    
}

// Rosh HaSahanah, Thishri 1
-(Day *) holidayRoshHaShanah:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    //NSLog(@"GYEAR: %d HYEAR: %d", year, hyear);
    
    Day *hday = [[Day alloc] initWithParams:1 month:TISHRI year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Rosh HaShanah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;}

// Yom Tippur, Tishri 10
-(Day *) holidayYomKippur:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:10 month:TISHRI year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Yom Kippur"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;    
}

// Sukkot, Tishri 15
-(Day *) holidaySukkot:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:15 month:TISHRI year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Sukkot"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

// HoShana Rabba, Tishri 21
-(Day *) holidayHoshanaRabba:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:21 month:TISHRI year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"HoShana Rabba"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

// Shemi Azereth, Thishri 22
-(Day *) holidaySheminiAzereth:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:22 month:TISHRI year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Shemini Azereth"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

// Simhat Torah, Tishri 23
-(Day *) holidaySimhatTorah:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:23 month:TISHRI year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Simhat Torah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

-(NSArray *) holidayHanukkah:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:25 month:KISLEV year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    for (int i = 0; i < 8; i++)
    {
        hday = [gcal gregorianFromFixedDate:(holidayRD + i)];
        [gcal correctDate:hday];
        [hday setName:@"Hanukkah"];
        [hday setCalendar:@"Hebrew"];
        
        [days addObject:hday];
    }
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return days;

}

// Beginning of Hanukkah, Kislev 25
-(Day *) holidayHanukkah1:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:25 month:KISLEV year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Hanukkah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

-(Day *) holidayHanukkah2:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:26 month:KISLEV year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Hanukkah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

-(Day *) holidayHanukkah3:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:27 month:KISLEV year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Hanukkah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

-(Day *) holidayHanukkah4:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:28 month:KISLEV year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Hanukkah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

-(Day *) holidayHanukkah5:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:29 month:KISLEV year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Hanukkah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

-(Day *) holidayHanukkah6:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    
    Day *hday;
    if ([self shortKislev:year]) 
    {
        hday = [[Day alloc] initWithParams:3 month:TEVETH year:hyear];    
    }
    else 
    {
        hday = [[Day alloc] initWithParams:30 month:KISLEV year:hyear];
    }
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Hanukkah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

-(Day *) holidayHanukkah7:(int)year;
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:1 month:TEVETH year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Hanukkah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

-(Day *) holidayHanukkah8:(int)year{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427] + 1;
    
    Day *hday = [[Day alloc] initWithParams:2 month:TEVETH year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Hanukkah"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

// Tu-B' Shevat, Shevat 15
-(Day *) holidayTuBShevat:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427];
    
    Day *hday = [[Day alloc] initWithParams:15 month:SHEVAT year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Tu-B' Shevat"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

// Purim, Adar I 14 (Adar II if leap year
-(Day *) holidayPurim:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427];
    
    Day *hday;
    
    if ([self isLeapYear:hyear])
    {
        hday = [[Day alloc] initWithParams:14 month:ADAR_I year:hyear];
    }
    else 
    {
        hday = [[Day alloc] initWithParams:14 month:ADAR_II year:hyear];
    }
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Purim"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}


// Passover, Nisan 15
-(Day *) holidayPassover:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427];
    
    Day *hday = [[Day alloc] initWithParams:15 month:NISAN year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Passover"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

// End of Passover, Nisan 21
-(Day *) holidayEndingOfPassover:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427];
    
    Day *hday = [[Day alloc] initWithParams:21 month:NISAN year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Ending of Passover"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}

// Shavuot, Sivan 6
-(Day *) holidayShavuot:(int)year
{
    GregorianCalendar *gcal = [GregorianCalendar alloc];
    
    int hyear = year - [gcal yearFromFixedDate:-1373427];
    
    Day *hday = [[Day alloc] initWithParams:6 month:SIVAN year:hyear];
    
    int holidayRD = [self fixedDateFromHebrew:hday];
    
    hday = [gcal gregorianFromFixedDate:holidayRD];
    
    [hday setName:@"Shavuot"];
    [hday setCalendar:@"Hebrew"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[hday name] UTF8String], [hday day], [hday month], [hday year]);
    
    return hday;
}



@end
