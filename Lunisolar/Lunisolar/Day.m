//
//  Day.m
//  Lunisolar
//
//  Created by Haley Smith on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Day.h"

@implementation Day

- (id) initWithParams:(int)dayInit month:(int)monthInit year:(int)yearInit 
{
    self = [super init];
    
	if (self) {
        [self setDay:dayInit];
        [self setMonth:monthInit];
        [self setYear:yearInit];
	}
	
	return self;
}

- (id) initWithName:(int)dayInit month:(int)monthInit year:(int)yearInit name:(NSString *)nameInit calendar:(NSString *)calendarInit;
{
    self = [super init];
    
    if (self) {
        [self setDay:dayInit];
        [self setMonth:monthInit];
        [self setYear:yearInit];
        [self setName:nameInit];
        [self setCalendar:calendarInit];
    }
    
    return self;
}

- (BOOL) compareDays:(Day *)otherDay
{
    return (day == [otherDay day] && month == [otherDay month] && year == [otherDay year]);
}

-(NSString *) printDay
{    
    NSString *s = [NSString stringWithFormat:@"\nDay: %d Month %d Year: %d Name: %@", day, month, year, name];
    
    return s;
}

/* GETTERS & SETTERS */
- (int)weekDay 
{
    return weekDay;
}

- (void)setWeekDay:(int)newValue 
{
    weekDay = newValue;
}


- (int)day {
    return day;
}

- (void)setDay:(int)newValue 
{
    day = newValue;
}


- (int)month {
    return month;
}

- (void)setMonth:(int)newValue 
{
    month = newValue;
}


- (int)year 
{
    return year;
}

- (void)setYear:(int)newValue 

{
    year = newValue;
}


- (int)dayOfYear 
{
    return dayOfYear;
}

- (void)setDayOfYear:(int)newValue 
{
    dayOfYear = newValue;
}


- (NSString *)name 
{
    return name;
}

- (void)setName:(NSString *)newValue 
{
    name = newValue;
}

- (NSString *)calendar
{
    return calendar;
}

- (void)setCalendar:(NSString *)newValue
{
    calendar = newValue;
}

- (Day *)nextDay
{
    return nextDay;
}

- (void)setNextDay:(Day *)newValue
{
    nextDay = newValue;
}


@end
