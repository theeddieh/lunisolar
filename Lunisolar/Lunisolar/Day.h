//
//  Day.h
//  Lunisolar
//
//  Created by Haley Smith on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject{
    
   	int weekDay, day, month, year, dayOfYear;
    NSString *name;
    NSString *calendar;
    Day *nextDay; // singly linked list fo multiple days
    
}

- (id) initWithParams:(int)dayInit month:(int)monthInit year:(int)yearInit; 

- (id) initWithName:(int)dayInit month:(int)monthInit year:(int)yearInit name:(NSString *)nameInit calendar:(NSString *)calendarInit;

- (BOOL) compareDays:(Day *)otherDay;

-(NSString *) printDay;

/* GETTERS & SETTERS */

- (int)weekDay;

- (void)setWeekDay:(int)newValue;


- (int)day;

- (void)setDay:(int)newValue;


- (int)month;

- (void)setMonth:(int)newValue;


- (int)year;

- (void)setYear:(int)newValue;


- (int)dayOfYear;

- (void)setDayOfYear:(int)newValue;


- (NSString *)name;

- (void)setName:(NSString *)newValue;

- (NSString *)calendar;

- (void)setCalendar:(NSString *)newValue;

- (Day *)nextDay;

- (void)setNextDay:(Day *)newValue;

@end
