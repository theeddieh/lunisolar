//
//  AmericanCalendar.m
//  Lunisolar
//
//  Created by  on 5/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AmericanCalendar.h"
#import "Day.h"

@implementation AmericanCalendar

/* FUNCTIONS */


// Return an R.D. date that represents a Gregorian date
-(int) fixedDateFromGregorian:(Day *) gDate
{
    // declare variables
    int yearMinusOne = [gDate year] - 1,
    rawDays = [gDate year]*365,
    numLeapYears = yearMinusOne/4,
    numHundredLeapYears = yearMinusOne/100,
    numFourHundredLeapYears = yearMinusOne/400,
    daysInPrevMonths = ([gDate month]*367 - 362)/12,
    rd, leapYearCorrection;
    
    if ([gDate month] <= 2) {
        leapYearCorrection = 0;
        
    } else if ([self isLeapYear:[gDate year]]) {
        leapYearCorrection = -1;
        
    } else {
        leapYearCorrection = -2;
        
    }          
    
    rd = rawDays + numLeapYears - numHundredLeapYears 
    + numFourHundredLeapYears + daysInPrevMonths
    + leapYearCorrection + [gDate day];
    
    return rd;
}

-(Day *) gregorianFromFixedDate:(int)rd
{
    int adjustedRD = rd + 365;
    
    int year = [self yearFromFixedDate:rd];
    
    int priorDays = adjustedRD - [self fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:1 year:year]];
    
    int correction;
    
    int fixedMarch = [self fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:3 year:year]];
    
    if (rd < fixedMarch)
    {
        correction = 0;
    }
    else if ( (rd >= fixedMarch) && ([self isLeapYear:year]) )
    {
        correction = 1;
    }
    else 
    {
        correction = 2;
    }
    
    int month = ( (12 * (priorDays + correction)) + 373) / 367;
    
    int day = adjustedRD - [self fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:month year:year]] + 1;
    
    //NSLog(@"In Gregorian day %d month %d year %d.", day,month,year);
    
    Day *d = [[Day alloc] initWithParams:day month:month year:year];
    
    [self correctDate:d];
    
    return d;
    
}

-(void) correctDate:(Day *)d
{
    // Check that the day and month are valid
    // If there are too many days, roll them over
    if ([self numberOfDaysInMonth:[d month] year:[d year]] < [d day])
    {
        // check for December. Roll over into next year. Month length calculation not affected
        if ([d month] == 12)
        {
            int newDay = [d day] - [self numberOfDaysInMonth:[d month] year:[d year]];
            [d setDay:newDay];
            [d setMonth:1];
            [d setYear:[d year] + 1];
        }
        else 
        {
            int newDay = [d day] - [self numberOfDaysInMonth:[d month] year:[d year]];
            [d setDay:newDay];
            [d setMonth:[d month] + 1];
        }
    }
}

-(int) yearFromFixedDate:(int)rd
{
    int d0 = rd - 1; //subtract the epoch
    int n400 = d0/146097;
    
    int d1 = d0 % 146097;
    int n100 = d1/36524;
    
    int d2 = d1 % 36524;
    int n4 = d2/1461;
    
    int d3 = d2 % 1461;
    int n1 = d3/365;
    
    int d4 = (d3 % 365) + 1;
    
    int year = (400 * n400) + (100 * n100) + (4 * n4) + (n1);
    
    if ( (n100 == 4) || (n1 == 4) )
    {
        return year;
    }
    
    return year + 1;                   
}

// Returns TRUE if the year is a leap year
-(BOOL) isLeapYear:(int) year
{
    if (year % 4 == 0) {
        if ((year % 400 != 100) && (year % 400 != 200) && (year % 400 != 300)) {
            return true;
        }
    }
    
    return false;
}

//Day of the week that the first of the month falls on, Sunday == 1
-(int) firstDayOfMonth:(int)month year:(int)year
{    
    int rd = [self fixedDateFromGregorian:[[Day alloc] initWithParams:1 month:month year:year]];
    
    int dayOfWeek = rd % 7;
    
    if (dayOfWeek == 0) {
        return 7;
    }
    
    return dayOfWeek;
}

// Returns the number of days in a month
-(int) numberOfDaysInMonth:(int)month year:(int)year
{
    BOOL leap = [self isLeapYear:year];
    
    if (month == FEBRUARY) {
        if (leap) {
            return 29;
        }
        return 28;
        
    } else if (month == SEPTEMBER || month == APRIL || month == JUNE || month == NOVEMBER) {
        return 30;
    }
    
    return 31;
}

//Date of the first Sunday on or before the month starts
-(Day *) startWeekOfMonth:(int)month year:(int)year
{
    int weekDay = [self firstDayOfMonth:month year:year];
    
    if (weekDay == 1) {
        return [[Day alloc] initWithParams:1 month:month year:year];
    }
    
    else if (month == JANUARY) {
        return [[Day alloc] initWithParams:[self numberOfDaysInMonth:DECEMBER year:year-1]-weekDay+2 month:DECEMBER year:year-1];
        
    }
    
    return [[Day alloc] initWithParams:[self numberOfDaysInMonth:month-1 year:year]-weekDay+2 month:month-1 year:year];
}

// Return number of weeks a month streches across
-(int) numberOfWeeksInMonth:(int)month year:(int)year
{
    int i = [self firstDayOfMonth:month year:year];
    
    if (i == 1)
    {
        if (![self isLeapYear:year] && month == FEBRUARY) 
        {
            // Four weeks for 28 days
            return 4;
        }
        return 5;
    } 
    
    int daysInCurrentMonth = [self numberOfDaysInMonth:month year:year];
    
    int daysInPeviousMonth = i - 1;
    
    int daysInNextMonth = 8 - [self firstDayOfMonth:(month + 1) year:year];
    
    if ( (daysInCurrentMonth + daysInPeviousMonth + daysInNextMonth) < 36)  
    {
        return 5;
    }
    else 
    {
        return 6;
    }
    
}

-(int) dayOfWeekFromFixedDate:(Day *)gDate
{
    int dayOfWeek = [self fixedDateFromGregorian:gDate] % 7;
    
    if (dayOfWeek == 0)
    {
        return 7;
    }
    
    return dayOfWeek;
}

// Generates list of holidays within the given year
- (NSArray *) getHolidays:(int)year
{
    NSMutableArray *holidays = [[NSMutableArray alloc] initWithCapacity:2];
    
    if ([self isLeapYear:year]){
        [holidays addObject:[self holidayLeapDay:year]];
    }
    
    [holidays addObject:[self holidayNewYearsDay:year]];
    [holidays addObject:[self holidayMLKDay:year]];
    [holidays addObject:[self holidayGroundhogDay:year]];
    [holidays addObject:[self holidayValentinesDay:year]];
    [holidays addObject:[self holidayIdesOfMarch:year]];
    [holidays addObject:[self holidayAprilFoolsDay:year]];
    [holidays addObject:[self holidayMemorialDay:year]];
    [holidays addObject:[self holiday4thOfJulyDay:year]];
    [holidays addObject:[self holidayLaborDay:year]];
    [holidays addObject:[self holidayHalloween:year]];
    [holidays addObject:[self holidayThanksgiving:year]];
    [holidays addObject:[self holidayNewYearsEve:year]];
    return holidays;
    
}


// NEW YEEARS DAY
-(Day *) holidayNewYearsDay:(int)year 
{
    return [[Day alloc] initWithName:1 month:1 year:year name:@"New Years Day" calendar:@"American"];
}

//MARTIN LUTHER KING DAY
-(Day *) holidayMLKDay:(int)year 
{
    Day *mlkDay =  [[Day alloc] initWithName:1 month:1 year:year name:@"MLK Day" calendar:@"American"];
    
    int mondays = 0;
    for(int i = 1; i <= 31; i++)
    {
        [mlkDay setDay:i];
        if ([self dayOfWeekFromFixedDate:mlkDay] == 2)
        {
            mondays++;
            if (mondays == 3)
            {
                break;
            }
        }
    }
    
    return mlkDay;
}

// GROUNDHOD DAY
-(Day *) holidayGroundhogDay:(int)year 
{
    return [[Day alloc] initWithName:2 month:2 year:year name:@"Groundhod Day" calendar:@"American"];
}

// VALENTINES DAY
-(Day *) holidayValentinesDay:(int)year 
{
    return [[Day alloc] initWithName:14 month:2 year:year name:@"Valentines Day" calendar:@"American"];
}

// LEAP DAY
-(Day *) holidayLeapDay:(int)year 
{
    return [[Day alloc] initWithName:29 month:2 year:year name:@"Leap Day" calendar:@"American"];
}

// IDES OF MARCH
-(Day *) holidayIdesOfMarch:(int)year
{
    return [[Day alloc] initWithName:15 month:3 year:year name:@"Ides of March" calendar:@"American"];
}

// APRIL FOOLS
-(Day *) holidayAprilFoolsDay:(int)year 
{
    return [[Day alloc] initWithName:1 month:4 year:year name:@"April Fools Day" calendar:@"American"];
}

// MEMORIAL DAY
-(Day *) holidayMemorialDay:(int)year
{
    
    Day *memorialDay = [[Day alloc] initWithName:1 month:5 year:year name:@"Memorial Day" calendar:@"American"];
    
    for(int i = 1; i <= 31; i++)
    {
        [memorialDay setDay:i];
        if ([self dayOfWeekFromFixedDate:memorialDay] == 2)
        {
            if (i >= 25)
            {
                break;
            }
        }
    }
    
    return memorialDay;
    
}
// 4TH OF JULY
-(Day *) holiday4thOfJulyDay:(int)year 
{
    return [[Day alloc] initWithName:4 month:7 year:year name:@"Indepenence Day" calendar:@"American"];
}

// LABOR DAY
-(Day *) holidayLaborDay:(int)year 
{
    Day *laborDay = [[Day alloc] initWithName:1 month:9 year:year name:@"Labor Day" calendar:@"American"];
    
    for(int i = 1; i <= 30; i++)
    {
        [laborDay setDay:i];
        if ([self dayOfWeekFromFixedDate:laborDay] == 2)
        {
            if (i <= 7)
            {
                break;
            }
        }
    }
    
    return laborDay;
}

// HALLOWEEN
-(Day *) holidayHalloween:(int)year 
{
    return [[Day alloc] initWithName:31 month:10 year:year name:@"Halloween" calendar:@"American"];
}

// THANKSGIVING
-(Day *) holidayThanksgiving:(int)year 
{
    Day *thanksgiving = [[Day alloc] initWithName:1 month:11 year:year name:@"Thanksgiving" calendar:@"American"];
    
    
    int thursdays = 0;
    for(int i = 1; i <= 30; i++)
    {
        [thanksgiving setDay:i];
        if ([self dayOfWeekFromFixedDate:thanksgiving] == 5)
        {
            thursdays++;
            if (thursdays == 4)
            {
                break;
            }
        }
    }
    
    return thanksgiving;
}

// NEW YEARS EVE
-(Day *) holidayNewYearsEve:(int)year 
{
    return [[Day alloc] initWithName:31 month:12 year:year name:@"New Year Eve" calendar:@"American"];
}




@end
