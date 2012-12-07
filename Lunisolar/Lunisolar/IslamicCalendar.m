//
//  IslamicCalendar.m
//  Lunisolar
//
//  Created by  on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IslamicCalendar.h"
#import "Day.h"
#import "GregorianCalendar.h"

@implementation IslamicCalendar

/* CONSTANTS */

int const
    MUHARRAM = 1,
    SAFAR = 2,
    RABI_I = 3,
    RABI_II = 4,
    JAMADA_I = 5,
    JAMADA_II = 6,
    RAJAB = 7,
    SHABAN = 8,
    RAMADAN = 9,
    SHAWWAL = 10,
    DHUALQADA = 11,
    DHUALHIJJA = 12;

int const ISLAMIC_EPOCH = 227015;

/* FUNCTIONS */

// If it is a leap year, Dhu al_hijja has 30 days instead of 29. Happens every
// 2nd, 5th, 7th, 10, 13th, 16th, 18th, 21st, 24th, 26th, adn 29th year of 30 year cycle.
-(BOOL) isLeapYear:(int)iyear
{
    return ( (14 + (11 * iyear)) % 30) < 11;
}

// Return R.D. date from Islamic date
-(int) fixedFromIslamic:(Day *)idate
{
    int days = [idate day];
    float monthsFloat = ([idate month] - 1) * 29.5;
    int months = ceil(monthsFloat);
    int years = ([idate year] - 1) * 354;
    int leaps = (3 + (11 * [idate year])) / 30;
    
    return days + months + years + leaps + ISLAMIC_EPOCH - 1;    
}

// Return Islamic date based on a fixed one
-(Day *) islamicFomFixed:(int)rd
{
    int year = ( (30 * (rd - ISLAMIC_EPOCH)) + 10646 ) / 10631;
    
    float mFloat = (rd - 29 - [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:1 year:year]]) / 29.5;
    int m = ceilf(mFloat);
    int month = MIN(12, m);
    
    int day = rd - [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:month year:year]];
    
    return [[Day alloc] initWithParams:day month:month year:year];
}

// Returns array of all holidays
-(NSArray *) getHolidays:(int)year
{
    NSMutableArray *holidays = [[NSMutableArray alloc] initWithCapacity:30];
    
    [holidays addObjectsFromArray:[self holidayRamadan:year]];
    [holidays addObjectsFromArray:[self holidayIslamicNewYear:year]];
    
    [holidays addObjectsFromArray:[self holidayAshura:year]];
    [holidays addObjectsFromArray:[self holidayMawlidAnNabi:year]];
    [holidays addObjectsFromArray:[self holidayAscentOfTheProphet:year]];
    [holidays addObjectsFromArray:[self holidayLailatAlKadr:year]];
    [holidays addObjectsFromArray:[self holidayLailatAlBaraa:year]];
    [holidays addObjectsFromArray:[self holidayIdAlFitr:year]];
    [holidays addObjectsFromArray:[self holidayIdAlAdha:year]];
    
    return holidays;

}

//RAMADAN
-(NSArray *) holidayRamadan:(int)year
{
    // Caluculate how many ramadans in a year
    
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:RAMADAN year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:RAMADAN year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:RAMADAN year:(iyear + 2)]];
    
    NSMutableArray *ramadan1 = [[NSMutableArray alloc] initWithCapacity:30];
    NSMutableArray *ramadan2 = [[NSMutableArray alloc] initWithCapacity:30];
    NSMutableArray *ramadan3 = [[NSMutableArray alloc] initWithCapacity:30];
    Day *r;
    
    //NSLog(@"\n Jan 1: %d\nDec 31: %d\n date1: %d\n date2: %d\n date3: %d\n", jan1, dec31, date1, date2, date3);
    
    // Check if the start of Ramadan falls in a year
    
    // First possible Ramadan starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
        for (int i = 0; i < 30; i++)
        {
            r = [g gregorianFromFixedDate:(date1 + i)];
            [r setYear:[r year] - 1];
            [r setName:@"Ramadan"];
            [r setCalendar:@"Islamic"];
            [ramadan1 addObject:r];
            
            //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        }
    }
    
    // First possible Ramadan starting before the year
    if ( (jan1 <= date1 + 29) && (date1 <= jan1) )
    {
        for (int i = date1 + 29 - jan1; i >= 0; i--)
        {
            r = [g gregorianFromFixedDate:(jan1 + i)];
            [r setYear:[r year] - 1];
            [r setName:@"Ramadan"];
            [r setCalendar:@"Islamic"];
            
            [ramadan1 addObject:r];
            
            //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        }
    }
    
    // Second possible Ramadan starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
        for (int i = 0; i < 30; i++)
        {
            r = [g gregorianFromFixedDate:(date2 + i)];
            [r setYear:[r year] - 1];
            [r setName:@"Ramadan"];
            [r setCalendar:@"Islamic"];
            
            [ramadan2 addObject:r];
            
            //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        }
    }
    
    // Second possible Ramadan starting before the year
    if ( (jan1 <= date2 + 29) && (date2 <= jan1) )
    {
        for (int i = date2 + 29 - jan1; i >= 0; i--)
        {
            r = [g gregorianFromFixedDate:(jan1 + i)];
            [r setYear:[r year] - 1];
            [r setName:@"Ramadan"];
            [r setCalendar:@"Islamic"];
            
            [ramadan2 addObject:r];
            
            //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        }
    }
    
    // Third possible Ramadan starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
        for (int i = 0; i <= 30; i++)
        {
            r = [g gregorianFromFixedDate:(date3 + i)];
            [r setYear:[r year] - 1];
            [r setName:@"Ramadan"];
            [r setCalendar:@"Islamic"];
            
            [ramadan3 addObject:r];
            
             //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        }
    }
    
    // Third possible Ramadan starting before the year
    if ( (jan1 <= date3 + 29) && (date3 <= jan1) )
    {
        for (int i = date3 + 29 - jan1; i >= 0; i--)
        {
            r = [g gregorianFromFixedDate:(jan1 + i)];
            [r setYear:[r year] - 1];
            [r setName:@"Ramadan"];
            [r setCalendar:@"Islamic"];
            
            [ramadan3 addObject:r];
            
            //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        }
    }
    
    //NSLog(@"\nSize of array 1: %d\nSize of array 2: %d\nSize of array 3: %d\n", [ramadan1 count], [ramadan2 count], [ramadan3 count]);
    
    [ramadan1 addObjectsFromArray:ramadan2];
    [ramadan1 addObjectsFromArray:ramadan3];
    
    return ramadan1;
}

// ISLAMIC NEW YEAR
-(NSArray *) holidayIslamicNewYear:(int)year
{
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    // all potentioal date ranges for Ramadan
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:MUHARRAM year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:MUHARRAM year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:MUHARRAM year:(iyear + 2)]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    Day *r;
    
    // First possible Holiday starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
            r = [g gregorianFromFixedDate:(date1)];
            [r setYear:[r year] - 1];
            [r setName:@"Islamic New Year"];
            [r setCalendar:@"Islamic"];
        
            [days addObject:r];
    }
    
    // Second possible Holiday starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
            r = [g gregorianFromFixedDate:(date2)];
            [r setYear:[r year] - 1];
            [r setName:@"Islamic New Year"];
            [r setCalendar:@"Islamic"];

            [days addObject:r];
    }
    
    // Third possible Holiday starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
            r = [g gregorianFromFixedDate:(date3)];
            [r setYear:[r year] - 1];
            [r setName:@"Islamic New Year"];
            [r setCalendar:@"Islamic"];
            
            [days addObject:r];
    }

    return days;

}

// Ashura
-(NSArray *) holidayAshura:(int)year
{
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    // all potentioal dates for holiday
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:10 month:MUHARRAM year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:10 month:MUHARRAM year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:10 month:MUHARRAM year:(iyear + 2)]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    Day *r;
    
    // First possible Holiday starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date1)];
        [r setYear:[r year] - 1];
        [r setName:@"Ashura"];
        [r setCalendar:@"Islamic"];
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Second possible Holiday starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date2)];
        [r setYear:[r year] - 1];
        [r setName:@"Ashura"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Third possible Holiday starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date3)];
        [r setYear:[r year] - 1];
        [r setName:@"Ashura"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    return days;

}

// Mawlid an-Nabi
-(NSArray *) holidayMawlidAnNabi:(int)year
{
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    // all potentioal dates for holiday
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:12 month:RABI_I year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:12 month:RABI_I year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:12 month:RABI_I year:(iyear + 2)]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    Day *r;
    
    // First possible Holiday starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date1)];
        [r setYear:[r year] - 1];
        [r setName:@"Mawlid an-Nabi"];
        [r setCalendar:@"Islamic"];
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Second possible Holiday starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date2)];
        [r setYear:[r year] - 1];
        [r setName:@"Mawlid an-Nabi"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Third possible Holiday starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date3)];
        [r setYear:[r year] - 1];
        [r setName:@"Mawlid an-Nabir"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    return days;
    
}
// Ascent of the Prophet
-(NSArray *) holidayAscentOfTheProphet:(int)year
{
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    // all potentioal dates for holiday
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:27 month:RAJAB year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:27 month:RAJAB year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:27 month:RAJAB year:(iyear + 2)]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    Day *r;
    
    // First possible Holiday starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date1)];
        [r setYear:[r year] - 1];
        [r setName:@"Ascent of the Prophet"];
        [r setCalendar:@"Islamic"];
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Second possible Holiday starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date2)];
        [r setYear:[r year] - 1];
        [r setName:@"Ascent of the Prophet"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Third possible Holiday starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date3)];
        [r setYear:[r year] - 1];
        [r setName:@"Ascent of the Prophetr"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    return days;
    
}

// Lailat-al-Kadr
-(NSArray *) holidayLailatAlKadr:(int)year
{
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    // all potentioal dates for holiday
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:27 month:RAMADAN year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:27 month:RAMADAN year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:27 month:RAMADAN year:(iyear + 2)]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    Day *r;
    
    // First possible Holiday starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date1)];
        [r setYear:[r year] - 1];
        [r setName:@"Lailat-al-Kadr"];
        [r setCalendar:@"Islamic"];
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Second possible Holiday starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date2)];
        [r setYear:[r year] - 1];
        [r setName:@"Lailat-al-Kadr"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Third possible Holiday starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date3)];
        [r setYear:[r year] - 1];
        [r setName:@"Lailat-al-Kadr"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    return days;
    
}

// Lailat-al-Baraa
-(NSArray *) holidayLailatAlBaraa:(int)year
{
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    // all potentioal dates for holiday
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:15 month:SHABAN year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:15 month:SHABAN year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:15 month:SHABAN year:(iyear + 2)]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    Day *r;
    
    // First possible Holiday starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date1)];
        [r setYear:[r year] - 1];
        [r setName:@"Lailat-al-Baraa"];
        [r setCalendar:@"Islamic"];
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Second possible Holiday starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date2)];
        [r setYear:[r year] - 1];
        [r setName:@"Lailat-al-Baraa"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Third possible Holiday starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date3)];
        [r setYear:[r year] - 1];
        [r setName:@"Lailat-al-Baraa"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    return days;
    
}

// Id-al-Fitr
-(NSArray *) holidayIdAlFitr:(int)year
{
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    // all potentioal dates for holiday
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:SHAWWAL year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:SHAWWAL year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:1 month:SHAWWAL year:(iyear + 2)]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    Day *r;
    
    // First possible Holiday starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date1)];
        [r setYear:[r year] - 1];
        [r setName:@"Id-al-Fitr"];
        [r setCalendar:@"Islamic"];
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Second possible Holiday starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date2)];
        [r setYear:[r year] - 1];
        [r setName:@"Id-al-Fitr"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Third possible Holiday starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date3)];
        [r setYear:[r year] - 1];
        [r setName:@"Id-al-Fitr"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    return days;
    
}

// Id-al-Adha
-(NSArray *) holidayIdAlAdha:(int)year
{
    GregorianCalendar *g = [GregorianCalendar alloc];
    
    int jan1 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    int dec31 = [g fixedDateFromGregorian:[[Day alloc] initWithParams:31 month:12 year:year]];
    int iyear = [[self islamicFomFixed:jan1] year];
    
    // all potentioal dates for holiday
    int date1 = [self fixedFromIslamic:[[Day alloc] initWithParams:10 month:DHUALHIJJA year:iyear]];
    int date2 = [self fixedFromIslamic:[[Day alloc] initWithParams:10 month:DHUALHIJJA year:(iyear + 1)]];
    int date3 = [self fixedFromIslamic:[[Day alloc] initWithParams:10 month:DHUALHIJJA year:(iyear + 2)]];
    
    NSMutableArray *days = [[NSMutableArray alloc] initWithCapacity:3];
    Day *r;
    
    // First possible Holiday starting withing the year
    if ( (jan1 <= date1) && (date1 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date1)];
        [r setYear:[r year] - 1];
        [r setName:@"Id-al-Adha"];
        [r setCalendar:@"Islamic"];
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Second possible Holiday starting withing the year
    if ( (jan1 <= date2) && (date2 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date2)];
        [r setYear:[r year] - 1];
        [r setName:@"Id-al-Adha"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    // Third possible Holiday starting withing the year
    if ( (jan1 <= date3) && (date3 <= dec31) )
    {
        r = [g gregorianFromFixedDate:(date3)];
        [r setYear:[r year] - 1];
        [r setName:@"Id-al-Adha"];
        [r setCalendar:@"Islamic"];
        
        [days addObject:r];
        
        //NSLog(@"Added %s on day %d month %d year %d.", [[r name] UTF8String], [r day], [r month], [r year]);
        
    }
    
    return days;
    
}

@end
