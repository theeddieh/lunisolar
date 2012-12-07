//
//  GregorianCalendar.m
//  Lunisolar
//
//  Created by Haley Smith on 3/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GregorianCalendar.h"
#import "AmericanCalendar.h"
#import "HebrewCalendar.h"
#import "IslamicCalendar.h"
#import "Calendar.h"
#import "Week.h"
#import "Day.h"

@implementation GregorianCalendar

/* CONSTANTS */

int const
JANUARY = 1,
FEBRUARY = 2,
MARCH = 3,
APRIL = 4,
MAY = 5,
JUNE = 6,
JULY = 7,
AUGUST = 8,
SEPTEMBER = 9,
OCTOBER = 10,
NOVEMBER = 11,
DECEMBER = 12;

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

// Reutrns a full year's worth od days and holidays
- (NSMutableArray *) fullYear:(int)year
{
    //Calendar *cal =  [[Calendar alloc] init];
    
    // 54*7 = 378
    NSMutableArray *yearOfDays = [[NSMutableArray alloc] initWithCapacity:378];
    
    Day *firstDay = [self startWeekOfMonth:1 year:year];
        
    // Last days of December, if need be
    if (firstDay.month == 12) 
    {
        for (int i = firstDay.day; i <= 31; i++)
        {
            [yearOfDays addObject:[[Day alloc] initWithParams: i month:12 year:year - 1]];
        }
    }
    
    
    // Add all the rest of the months. It's a little messy, but I think it aught to do.
    
    int i;
    // January
    for (i = 1; i <= 31; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:1 year:year]];
    }
    // February
    for (i = 1; i <= 28; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:2 year:year]];
    }
    // Leap Year
    if ([self isLeapYear:year])
    {
     [yearOfDays addObject:[[Day alloc] initWithParams: 29 month:2 year:year]];   
    }
    // March
    for (i = 1; i <= 31; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:3 year:year]];
    }
    // April
    for (i = 1; i <= 30; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:4 year:year]];
    }
    // May
    for (i = 1; i <= 31; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:5 year:year]];
    }
    // June
    for (i = 1; i <= 30; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:6 year:year]];
    }
    // July
    for (i = 1; i <= 31; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:7 year:year]];
    }
    // August
    for (i = 1; i <= 31; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:8 year:year]];
    }
    // Semptember
    for (i = 1; i <= 30; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:9 year:year]];
    }
    // October
    for (i = 1; i <= 31; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:10 year:year]];
    }
    // November
    for (i = 1; i <= 30; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:11 year:year]];
    }
    // December
    for (i = 1; i <= 31; i++){
        [yearOfDays addObject:[[Day alloc] initWithParams: i month:12 year:year]];
    }
    
    if ([yearOfDays count] < 378) 
    {
        int tempDay = 1;
        for (i = [yearOfDays count]; i <= 378; i++)
        {
            [yearOfDays addObject:[[Day alloc] initWithParams: tempDay month:1 year:year + 1]];
            tempDay++;
        }

    }
    
    
    // Add Gregorian Calendar
    [self mergeHolidays:yearOfDays holidayCal:[self getHolidays:year]];
    
    // Add Hebrew Calendar
    [self mergeHolidays:yearOfDays holidayCal:[[HebrewCalendar alloc] getHolidays:year]];
    
    // Add American Calendar
    [self mergeHolidays:yearOfDays holidayCal:[[AmericanCalendar alloc] getHolidays:year]];
    
    // Add Islamic Calendar
    [self mergeHolidays:yearOfDays holidayCal:[[IslamicCalendar alloc] getHolidays:year]];
    
    return yearOfDays;
}

// Inserts holidays in HolidayCal in the main YearCal
- (void) mergeHolidays:(NSArray *)yearCal holidayCal:(NSArray *)holidayCal
{
    for (int i = 0; i < [yearCal count]; i++)
    {
        for (int j = 0; j < [holidayCal count]; j++)
        {
            Day *date = [yearCal objectAtIndex:i];
            Day *holiday = [holidayCal objectAtIndex:j];
            
            if ([date compareDays:holiday])
            {
                Day *walker = date;
                
                // Builds linked list of holidays
                while ([walker nextDay] != NULL) 
                {
                    walker = [walker nextDay];
                }
                
                [walker setNextDay:holiday];
            }
        }
    }
}




// Generates list of holidays within the given year
- (NSArray *) getHolidays:(int)year
{
    NSMutableArray *holidays = [[NSMutableArray alloc] initWithCapacity:2];
    
    Day *easter = [self holidayEaster:year];
    
    [holidays addObject:easter];
    [holidays addObject:[self holidayAshWednesday:easter]];
    [holidays addObject:[self holidayPalmSunday:easter]];
    [holidays addObject:[self holidayAllSaintsDay:year]];
    [holidays addObject:[self holidayChristams:year]];
    
    return holidays;

}


// EASTER
-(Day *) holidayEaster:(int)year
{
    
    // Calculate the next Paschal Moon
    int century = (year / 100) + 1;
    
    int shiftedEpact = (  (14 + (11 * (year % 19))) 
                        - ((3 * century) / 4) 
                        + ((5 + (8 * century)) / 25) ) 
                        % 30;
    
    int adjectedEpact = shiftedEpact;
    
    if ( (shiftedEpact == 0) || ((shiftedEpact == 1) && (10 < year % 19)) )
    {
        adjectedEpact = shiftedEpact + 1;
    }
    
    int paschalMoon = [self fixedDateFromGregorian:[[Day alloc] initWithParams:19 month:4 year:year]] - adjectedEpact;
    
    // Calculate the next Sunday after the Pashcal Moon
    
    
    int eDay = paschalMoon - 365;
    Day *day = [self gregorianFromFixedDate:eDay];
    
    for(int i = 0; i < 7; i++)
    {
        eDay = paschalMoon + i;
        day = [self gregorianFromFixedDate:eDay];
        
        
        if ([self dayOfWeekFromFixedDate:day] == 1)
        {
            
            break;
        }
    }
    
    
    Day *easter = [self gregorianFromFixedDate:eDay];
    
    [easter setYear:[easter year] - 1];
    
    if ([easter year] % 4 == 3)
    {
        [easter setDay:[easter day] + 2];
    }
    else 
    {
        [easter setDay:[easter day] + 1];
    }
    
    [self correctDate:easter];
                   
    
    [easter setName:@"Easter"];
    [easter setCalendar:@"Gregorian"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[easter name] UTF8String], [easter day], [easter month], [easter year]);
    
    return easter;
        
}

// ASH WEDNESDAY
-(Day *) holidayAshWednesday:(Day *)easter;
{
    // 46 days before Easter
    int ashFixed = [self fixedDateFromGregorian:easter];
    
    ashFixed = ashFixed - 46;
    
    Day *ashDay = [self gregorianFromFixedDate:ashFixed];
    
    
    [ashDay setYear:[ashDay year] - 1];
    
    
    if ([self dayOfWeekFromFixedDate:ashDay] == 3)
    {
        [ashDay setDay:[ashDay day] + 1];
        [self correctDate:ashDay];
    }
    
    /*
    
    if ([ashDay year] % 4 == 3)
    {
        [ashDay setDay:[ashDay day] + 1];
        [self correctDate:ashDay];
    }
    */
    [ashDay setName:@"Ash Wednesday"];
    [ashDay setCalendar:@"Gregorian"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[ashDay name] UTF8String], [ashDay day], [ashDay month], [ashDay year]);
    
    return ashDay;
    
    
    //return [[Day alloc] initWithName:25 month:2 year:year name:@"Ash Wednesday" calendar:@"Gregorian"];
}

// EASTER
-(Day *) holidayPalmSunday:(Day *)easter
{
    
    // The Sunday before Easter
    int palmFixed = [self fixedDateFromGregorian:easter];

    palmFixed = palmFixed - 7;
    
    Day *palmDay = [self gregorianFromFixedDate:palmFixed];
    
    [palmDay setYear:[palmDay year] - 1];
    
    if ([palmDay year] % 4 == 3)
    {
        [palmDay setDay:[palmDay day] + 1];
        [self correctDate:palmDay];
    }
    
    [palmDay setName:@"Palm Sunday"];
    [palmDay setCalendar:@"Gregorian"];
    
    //NSLog(@"Added %s on day %d month %d year %d.", [[palmDay name] UTF8String], [palmDay day], [palmDay month], [palmDay year]);
    
    return palmDay;
}

// ALL SAINTS DAY
-(Day *) holidayAllSaintsDay:(int)year 
{
    return [[Day alloc] initWithName:1 month:11 year:year name:@"All Saints Day" calendar:@"Gregorian"];
}

// CHRISTMAS
-(Day *) holidayChristams:(int)year 
{
    return [[Day alloc] initWithName:25 month:12 year:year name:@"Christmas" calendar:@"Gregorian"];
}



@end
