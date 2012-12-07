//
//  Calendar.m
//  Lunisolar
//
//  Created by Haley Smith on 3/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Calendar.h"
#import "Week.h"
#import "Day.h"

@implementation Calendar


/*
- (id) initWithSampleYear {
    
	self = [super init];
    
	if(self){
		// initialize here
		self->year = [[NSNumber alloc] initWithInt:2012];
        self->weeks = [[NSMutableArray alloc] init];
        
        NSMutableArray *week1 =[[NSMutableArray alloc] initWithCapacity:7];
        [week1 addObject:(Day *)[[Day alloc] initWithParams:1 month:1]];
        [week1 addObject:(Day *)[[Day alloc] initWithParams:2 month:1]];
        [week1 addObject:(Day *)[[Day alloc] initWithParams:3 month:1]];
        [week1 addObject:(Day *)[[Day alloc] initWithParams:4 month:1]];
        [week1 addObject:(Day *)[[Day alloc] initWithParams:5 month:1]];
        [week1 addObject:(Day *)[[Day alloc] initWithParams:6 month:1]];
        [week1 addObject:(Day *)[[Day alloc] initWithParams:7 month:1]];
        Week *w1 = [[Week alloc] initWithParams:1 days:week1];
        [weeks addObject:w1];
        
        
        NSMutableArray *week2 =[[NSMutableArray alloc] initWithCapacity:7];
        [week2 addObject:(Day *)[[Day alloc] initWithParams:8 month:1]];
        [week2 addObject:(Day *)[[Day alloc] initWithParams:9 month:1]];
        [week2 addObject:(Day *)[[Day alloc] initWithParams:10 month:1]];
        [week2 addObject:(Day *)[[Day alloc] initWithParams:11 month:1]];
        [week2 addObject:(Day *)[[Day alloc] initWithParams:12 month:1]];
        [week2 addObject:(Day *)[[Day alloc] initWithParams:13 month:1]];
        [week2 addObject:(Day *)[[Day alloc] initWithParams:14 month:1]];
        Week *w2 = [[Week alloc] initWithParams:2 days:week2];
        [weeks addObject:w2];
        
        
        NSMutableArray *week3 =[[NSMutableArray alloc] initWithCapacity:7];
        [week3 addObject:(Day *)[[Day alloc] initWithParams:15 month:1]];
        [week3 addObject:(Day *)[[Day alloc] initWithParams:16 month:1]];
        [week3 addObject:(Day *)[[Day alloc] initWithParams:17 month:1]];
        [week3 addObject:(Day *)[[Day alloc] initWithParams:18 month:1]];
        [week3 addObject:(Day *)[[Day alloc] initWithParams:19 month:1]];
        [week3 addObject:(Day *)[[Day alloc] initWithParams:20 month:1]];
        [week3 addObject:(Day *)[[Day alloc] initWithParams:21 month:1]];
        Week *w3 = [[Week alloc] initWithParams:3 days:week3];
        [weeks addObject:w3];
        
        
        NSMutableArray *week4 =[[NSMutableArray alloc] initWithCapacity:7];
        [week4 addObject:(Day *)[[Day alloc] initWithParams:22 month:1]];
        [week4 addObject:(Day *)[[Day alloc] initWithParams:23 month:1]];
        [week4 addObject:(Day *)[[Day alloc] initWithParams:24 month:1]];
        [week4 addObject:(Day *)[[Day alloc] initWithParams:25 month:1]];
        [week4 addObject:(Day *)[[Day alloc] initWithParams:26 month:1]];
        [week4 addObject:(Day *)[[Day alloc] initWithParams:27 month:1]];
        [week4 addObject:(Day *)[[Day alloc] initWithParams:28 month:1]];
        Week *w4 = [[Week alloc] initWithParams:4 days:week4];
        [weeks addObject:w4];
        
        
        NSMutableArray *week5 =[[NSMutableArray alloc] initWithCapacity:7];
        [week5 addObject:(Day *)[[Day alloc] initWithParams:29 month:1]];
        [week5 addObject:(Day *)[[Day alloc] initWithParams:30 month:1]];
        [week5 addObject:(Day *)[[Day alloc] initWithParams:31 month:1]];
        [week5 addObject:(Day *)[[Day alloc] initWithParams:1 month:2]];
        [week5 addObject:(Day *)[[Day alloc] initWithParams:2 month:2]];
        [week5 addObject:(Day *)[[Day alloc] initWithParams:3 month:2]];
        [week5 addObject:(Day *)[[Day alloc] initWithParams:4 month:2]];
        Week *w5 = [[Week alloc] initWithParams:5 days:week5];
        [weeks addObject:w5];
        
        
        NSMutableArray *week6 =[[NSMutableArray alloc] initWithCapacity:7];
        [week6 addObject:(Day *)[[Day alloc] initWithParams:5 month:2]];
        [week6 addObject:(Day *)[[Day alloc] initWithParams:6 month:2]];
        [week6 addObject:(Day *)[[Day alloc] initWithParams:7 month:2]];
        [week6 addObject:(Day *)[[Day alloc] initWithParams:8 month:2]];
        [week6 addObject:(Day *)[[Day alloc] initWithParams:9 month:2]];
        [week6 addObject:(Day *)[[Day alloc] initWithParams:10 month:2]];
        [week6 addObject:(Day *)[[Day alloc] initWithParams:11 month:2]];
        Week *w6 = [[Week alloc] initWithParams:6 days:week6];
        [weeks addObject:w6];
        
        
        NSMutableArray *week7 =[[NSMutableArray alloc] initWithCapacity:7];
        [week7 addObject:(Day *)[[Day alloc] initWithParams:12 month:2]];
        [week7 addObject:(Day *)[[Day alloc] initWithParams:13 month:2]];
        [week7 addObject:(Day *)[[Day alloc] initWithParams:14 month:2]];
        [week7 addObject:(Day *)[[Day alloc] initWithParams:15 month:2]];
        [week7 addObject:(Day *)[[Day alloc] initWithParams:16 month:2]];
        [week7 addObject:(Day *)[[Day alloc] initWithParams:17 month:2]];
        [week7 addObject:(Day *)[[Day alloc] initWithParams:18 month:2]];
        Week *w7 = [[Week alloc] initWithParams:7 days:week7];
        [weeks addObject:w7];
        
        
        NSMutableArray *week8 =[[NSMutableArray alloc] initWithCapacity:7];
        [week8 addObject:(Day *)[[Day alloc] initWithParams:19 month:2]];
        [week8 addObject:(Day *)[[Day alloc] initWithParams:20 month:2]];
        [week8 addObject:(Day *)[[Day alloc] initWithParams:21 month:2]];
        [week8 addObject:(Day *)[[Day alloc] initWithParams:22 month:2]];
        [week8 addObject:(Day *)[[Day alloc] initWithParams:23 month:2]];
        [week8 addObject:(Day *)[[Day alloc] initWithParams:24 month:2]];
        [week8 addObject:(Day *)[[Day alloc] initWithParams:25 month:2]];
        Week *w8 = [[Week alloc] initWithParams:8 days:week8];
        [weeks addObject:w8];
        
        
        NSMutableArray *week9 =[[NSMutableArray alloc] initWithCapacity:7];
        [week9 addObject:(Day *)[[Day alloc] initWithParams:26 month:2]];
        [week9 addObject:(Day *)[[Day alloc] initWithParams:27 month:2]];
        [week9 addObject:(Day *)[[Day alloc] initWithParams:28 month:2]];
        [week9 addObject:(Day *)[[Day alloc] initWithParams:29 month:2]];
        [week9 addObject:(Day *)[[Day alloc] initWithParams:1 month:3]];
        [week9 addObject:(Day *)[[Day alloc] initWithParams:2 month:3]];
        [week9 addObject:(Day *)[[Day alloc] initWithParams:3 month:3]];
        Week *w9 = [[Week alloc] initWithParams:9 days:week9];
        [weeks addObject:w9];
        
        
        NSMutableArray *week10 =[[NSMutableArray alloc] initWithCapacity:7];
        [week10 addObject:(Day *)[[Day alloc] initWithParams:4 month:3]];
        [week10 addObject:(Day *)[[Day alloc] initWithParams:5 month:3]];
        [week10 addObject:(Day *)[[Day alloc] initWithParams:6 month:3]];
        [week10 addObject:(Day *)[[Day alloc] initWithParams:7 month:3]];
        [week10 addObject:(Day *)[[Day alloc] initWithParams:8 month:3]];
        [week10 addObject:(Day *)[[Day alloc] initWithParams:9 month:3]];
        [week10 addObject:(Day *)[[Day alloc] initWithParams:10 month:3]];
        Week *w10 = [[Week alloc] initWithParams:10 days:week10];
        [weeks addObject:w10];
        
        
        NSMutableArray *week11 =[[NSMutableArray alloc] initWithCapacity:7];
        [week11 addObject:(Day *)[[Day alloc] initWithParams:11 month:3]];
        [week11 addObject:(Day *)[[Day alloc] initWithParams:12 month:3]];
        [week11 addObject:(Day *)[[Day alloc] initWithParams:13 month:3]];
        [week11 addObject:(Day *)[[Day alloc] initWithParams:14 month:3]];
        [week11 addObject:(Day *)[[Day alloc] initWithParams:15 month:3]];
        [week11 addObject:(Day *)[[Day alloc] initWithParams:16 month:3]];
        [week11 addObject:(Day *)[[Day alloc] initWithParams:17 month:3]];
        Week *w11 = [[Week alloc] initWithParams:11 days:week11];
        [weeks addObject:w11];
        
        
        NSMutableArray *week12 =[[NSMutableArray alloc] initWithCapacity:7];
        [week12 addObject:(Day *)[[Day alloc] initWithParams:18 month:3]];
        [week12 addObject:(Day *)[[Day alloc] initWithParams:19 month:3]];
        [week12 addObject:(Day *)[[Day alloc] initWithParams:20 month:3]];
        [week12 addObject:(Day *)[[Day alloc] initWithParams:21 month:3]];
        [week12 addObject:(Day *)[[Day alloc] initWithParams:22 month:3]];
        [week12 addObject:(Day *)[[Day alloc] initWithParams:23 month:3]];
        [week12 addObject:(Day *)[[Day alloc] initWithParams:24 month:3]];
        Week *w12 = [[Week alloc] initWithParams:12 days:week12];
        [weeks addObject:w12];
        
        
        NSMutableArray *week13 =[[NSMutableArray alloc] initWithCapacity:7];
        [week13 addObject:(Day *)[[Day alloc] initWithParams:25 month:3]];
        [week13 addObject:(Day *)[[Day alloc] initWithParams:26 month:3]];
        [week13 addObject:(Day *)[[Day alloc] initWithParams:27 month:3]];
        [week13 addObject:(Day *)[[Day alloc] initWithParams:28 month:3]];
        [week13 addObject:(Day *)[[Day alloc] initWithParams:29 month:3]];
        [week13 addObject:(Day *)[[Day alloc] initWithParams:30 month:3]];
        [week13 addObject:(Day *)[[Day alloc] initWithParams:31 month:3]];
        Week *w13 = [[Week alloc] initWithParams:13 days:week13];
        [weeks addObject:w13];
        
        
        NSMutableArray *week14 =[[NSMutableArray alloc] initWithCapacity:7];
        [week14 addObject:(Day *)[[Day alloc] initWithParams:1 month:4]];
        [week14 addObject:(Day *)[[Day alloc] initWithParams:2 month:4]];
        [week14 addObject:(Day *)[[Day alloc] initWithParams:3 month:4]];
        [week14 addObject:(Day *)[[Day alloc] initWithParams:4 month:4]];
        [week14 addObject:(Day *)[[Day alloc] initWithParams:5 month:4]];
        [week14 addObject:(Day *)[[Day alloc] initWithParams:6 month:4]];
        [week14 addObject:(Day *)[[Day alloc] initWithParams:7 month:4]];
        Week *w14 = [[Week alloc] initWithParams:14 days:week14];
        [weeks addObject:w14];
        
        
        NSMutableArray *week15 =[[NSMutableArray alloc] initWithCapacity:7];
        [week15 addObject:(Day *)[[Day alloc] initWithParams:8 month:4]];
        [week15 addObject:(Day *)[[Day alloc] initWithParams:9 month:4]];
        [week15 addObject:(Day *)[[Day alloc] initWithParams:10 month:4]];
        [week15 addObject:(Day *)[[Day alloc] initWithParams:11 month:4]];
        [week15 addObject:(Day *)[[Day alloc] initWithParams:12 month:4]];
        [week15 addObject:(Day *)[[Day alloc] initWithParams:13 month:4]];
        [week15 addObject:(Day *)[[Day alloc] initWithParams:14 month:4]];
        Week *w15 = [[Week alloc] initWithParams:15 days:week15];
        [weeks addObject:w15];
        
        
        NSMutableArray *week16 =[[NSMutableArray alloc] initWithCapacity:7];
        [week16 addObject:(Day *)[[Day alloc] initWithParams:15 month:4]];
        [week16 addObject:(Day *)[[Day alloc] initWithParams:16 month:4]];
        [week16 addObject:(Day *)[[Day alloc] initWithParams:17 month:4]];
        [week16 addObject:(Day *)[[Day alloc] initWithParams:18 month:4]];
        [week16 addObject:(Day *)[[Day alloc] initWithParams:19 month:4]];
        [week16 addObject:(Day *)[[Day alloc] initWithParams:20 month:4]];
        [week16 addObject:(Day *)[[Day alloc] initWithParams:21 month:4]];
        Week *w16 = [[Week alloc] initWithParams:16 days:week16];
        [weeks addObject:w16];
        
        
        NSMutableArray *week17 =[[NSMutableArray alloc] initWithCapacity:7];
        [week17 addObject:(Day *)[[Day alloc] initWithParams:22 month:4]];
        [week17 addObject:(Day *)[[Day alloc] initWithParams:23 month:4]];
        [week17 addObject:(Day *)[[Day alloc] initWithParams:24 month:4]];
        [week17 addObject:(Day *)[[Day alloc] initWithParams:25 month:4]];
        [week17 addObject:(Day *)[[Day alloc] initWithParams:26 month:4]];
        [week17 addObject:(Day *)[[Day alloc] initWithParams:27 month:4]];
        [week17 addObject:(Day *)[[Day alloc] initWithParams:28 month:4]];
        Week *w17 = [[Week alloc] initWithParams:17 days:week17];
        [weeks addObject:w17];
        
        
        NSMutableArray *week18 =[[NSMutableArray alloc] initWithCapacity:7];
        [week18 addObject:(Day *)[[Day alloc] initWithParams:29 month:4]];
        [week18 addObject:(Day *)[[Day alloc] initWithParams:30 month:4]];
        [week18 addObject:(Day *)[[Day alloc] initWithParams:1 month:5]];
        [week18 addObject:(Day *)[[Day alloc] initWithParams:2 month:5]];
        [week18 addObject:(Day *)[[Day alloc] initWithParams:3 month:5]];
        [week18 addObject:(Day *)[[Day alloc] initWithParams:4 month:5]];
        [week18 addObject:(Day *)[[Day alloc] initWithParams:5 month:5]];
        Week *w18 = [[Week alloc] initWithParams:18 days:week18];
        [weeks addObject:w18];
        
        
        NSMutableArray *week19 =[[NSMutableArray alloc] initWithCapacity:7];
        [week19 addObject:(Day *)[[Day alloc] initWithParams:6 month:5]];
        [week19 addObject:(Day *)[[Day alloc] initWithParams:7 month:5]];
        [week19 addObject:(Day *)[[Day alloc] initWithParams:8 month:5]];
        [week19 addObject:(Day *)[[Day alloc] initWithParams:9 month:5]];
        [week19 addObject:(Day *)[[Day alloc] initWithParams:10 month:5]];
        [week19 addObject:(Day *)[[Day alloc] initWithParams:11 month:5]];
        [week19 addObject:(Day *)[[Day alloc] initWithParams:12 month:5]];
        Week *w19 = [[Week alloc] initWithParams:19 days:week19];
        [weeks addObject:w19];
        
        
        NSMutableArray *week20 =[[NSMutableArray alloc] initWithCapacity:7];
        [week20 addObject:(Day *)[[Day alloc] initWithParams:13 month:5]];
        [week20 addObject:(Day *)[[Day alloc] initWithParams:14 month:5]];
        [week20 addObject:(Day *)[[Day alloc] initWithParams:15 month:5]];
        [week20 addObject:(Day *)[[Day alloc] initWithParams:16 month:5]];
        [week20 addObject:(Day *)[[Day alloc] initWithParams:17 month:5]];
        [week20 addObject:(Day *)[[Day alloc] initWithParams:18 month:5]];
        [week20 addObject:(Day *)[[Day alloc] initWithParams:19 month:5]];
        Week *w20 = [[Week alloc] initWithParams:20 days:week20];
        [weeks addObject:w20];
        
        
        NSMutableArray *week21 =[[NSMutableArray alloc] initWithCapacity:7];
        [week21 addObject:(Day *)[[Day alloc] initWithParams:20 month:5]];
        [week21 addObject:(Day *)[[Day alloc] initWithParams:21 month:5]];
        [week21 addObject:(Day *)[[Day alloc] initWithParams:22 month:5]];
        [week21 addObject:(Day *)[[Day alloc] initWithParams:23 month:5]];
        [week21 addObject:(Day *)[[Day alloc] initWithParams:24 month:5]];
        [week21 addObject:(Day *)[[Day alloc] initWithParams:25 month:5]];
        [week21 addObject:(Day *)[[Day alloc] initWithParams:26 month:5]];
        Week *w21 = [[Week alloc] initWithParams:21 days:week21];
        [weeks addObject:w21];
        
        
        NSMutableArray *week22 =[[NSMutableArray alloc] initWithCapacity:7];
        [week22 addObject:(Day *)[[Day alloc] initWithParams:27 month:5]];
        [week22 addObject:(Day *)[[Day alloc] initWithParams:28 month:5]];
        [week22 addObject:(Day *)[[Day alloc] initWithParams:29 month:5]];
        [week22 addObject:(Day *)[[Day alloc] initWithParams:30 month:5]];
        [week22 addObject:(Day *)[[Day alloc] initWithParams:31 month:5]];
        [week22 addObject:(Day *)[[Day alloc] initWithParams:1 month:6]];
        [week22 addObject:(Day *)[[Day alloc] initWithParams:2 month:6]];
        Week *w22 = [[Week alloc] initWithParams:22 days:week22];
        [weeks addObject:w22];
        
        
        NSMutableArray *week23 =[[NSMutableArray alloc] initWithCapacity:7];
        [week23 addObject:(Day *)[[Day alloc] initWithParams:3 month:6]];
        [week23 addObject:(Day *)[[Day alloc] initWithParams:4 month:6]];
        [week23 addObject:(Day *)[[Day alloc] initWithParams:5 month:6]];
        [week23 addObject:(Day *)[[Day alloc] initWithParams:6 month:6]];
        [week23 addObject:(Day *)[[Day alloc] initWithParams:7 month:6]];
        [week23 addObject:(Day *)[[Day alloc] initWithParams:8 month:6]];
        [week23 addObject:(Day *)[[Day alloc] initWithParams:9 month:6]];
        Week *w23 = [[Week alloc] initWithParams:23 days:week23];
        [weeks addObject:w23];
        
        
        NSMutableArray *week24 =[[NSMutableArray alloc] initWithCapacity:7];
        [week24 addObject:(Day *)[[Day alloc] initWithParams:10 month:6]];
        [week24 addObject:(Day *)[[Day alloc] initWithParams:11 month:6]];
        [week24 addObject:(Day *)[[Day alloc] initWithParams:12 month:6]];
        [week24 addObject:(Day *)[[Day alloc] initWithParams:13 month:6]];
        [week24 addObject:(Day *)[[Day alloc] initWithParams:14 month:6]];
        [week24 addObject:(Day *)[[Day alloc] initWithParams:15 month:6]];
        [week24 addObject:(Day *)[[Day alloc] initWithParams:16 month:6]];
        Week *w24 = [[Week alloc] initWithParams:24 days:week24];
        [weeks addObject:w24];
        
        
        NSMutableArray *week25 =[[NSMutableArray alloc] initWithCapacity:7];
        [week25 addObject:(Day *)[[Day alloc] initWithParams:17 month:6]];
        [week25 addObject:(Day *)[[Day alloc] initWithParams:18 month:6]];
        [week25 addObject:(Day *)[[Day alloc] initWithParams:19 month:6]];
        [week25 addObject:(Day *)[[Day alloc] initWithParams:20 month:6]];
        [week25 addObject:(Day *)[[Day alloc] initWithParams:21 month:6]];
        [week25 addObject:(Day *)[[Day alloc] initWithParams:22 month:6]];
        [week25 addObject:(Day *)[[Day alloc] initWithParams:23 month:6]];
        Week *w25 = [[Week alloc] initWithParams:25 days:week25];
        [weeks addObject:w25];
        
        
        NSMutableArray *week26 =[[NSMutableArray alloc] initWithCapacity:7];
        [week26 addObject:(Day *)[[Day alloc] initWithParams:24 month:6]];
        [week26 addObject:(Day *)[[Day alloc] initWithParams:25 month:6]];
        [week26 addObject:(Day *)[[Day alloc] initWithParams:26 month:6]];
        [week26 addObject:(Day *)[[Day alloc] initWithParams:27 month:6]];
        [week26 addObject:(Day *)[[Day alloc] initWithParams:28 month:6]];
        [week26 addObject:(Day *)[[Day alloc] initWithParams:29 month:6]];
        [week26 addObject:(Day *)[[Day alloc] initWithParams:30 month:6]];
        Week *w26 = [[Week alloc] initWithParams:26 days:week26];
        [weeks addObject:w26];
        
        
        NSMutableArray *week27 =[[NSMutableArray alloc] initWithCapacity:7];
        [week27 addObject:(Day *)[[Day alloc] initWithParams:1 month:7]];
        [week27 addObject:(Day *)[[Day alloc] initWithParams:2 month:7]];
        [week27 addObject:(Day *)[[Day alloc] initWithParams:3 month:7]];
        [week27 addObject:(Day *)[[Day alloc] initWithParams:4 month:7]];
        [week27 addObject:(Day *)[[Day alloc] initWithParams:5 month:7]];
        [week27 addObject:(Day *)[[Day alloc] initWithParams:6 month:7]];
        [week27 addObject:(Day *)[[Day alloc] initWithParams:7 month:7]];
        Week *w27 = [[Week alloc] initWithParams:27 days:week27];
        [weeks addObject:w27];
        
        
        NSMutableArray *week28 =[[NSMutableArray alloc] initWithCapacity:7];
        [week28 addObject:(Day *)[[Day alloc] initWithParams:8 month:7]];
        [week28 addObject:(Day *)[[Day alloc] initWithParams:9 month:7]];
        [week28 addObject:(Day *)[[Day alloc] initWithParams:10 month:7]];
        [week28 addObject:(Day *)[[Day alloc] initWithParams:11 month:7]];
        [week28 addObject:(Day *)[[Day alloc] initWithParams:12 month:7]];
        [week28 addObject:(Day *)[[Day alloc] initWithParams:13 month:7]];
        [week28 addObject:(Day *)[[Day alloc] initWithParams:14 month:7]];
        Week *w28 = [[Week alloc] initWithParams:28 days:week28];
        [weeks addObject:w28];
        
        
        NSMutableArray *week29 =[[NSMutableArray alloc] initWithCapacity:7];
        [week29 addObject:(Day *)[[Day alloc] initWithParams:15 month:7]];
        [week29 addObject:(Day *)[[Day alloc] initWithParams:16 month:7]];
        [week29 addObject:(Day *)[[Day alloc] initWithParams:17 month:7]];
        [week29 addObject:(Day *)[[Day alloc] initWithParams:18 month:7]];
        [week29 addObject:(Day *)[[Day alloc] initWithParams:19 month:7]];
        [week29 addObject:(Day *)[[Day alloc] initWithParams:20 month:7]];
        [week29 addObject:(Day *)[[Day alloc] initWithParams:21 month:7]];
        Week *w29 = [[Week alloc] initWithParams:29 days:week29];
        [weeks addObject:w29];
        
        
        NSMutableArray *week30 =[[NSMutableArray alloc] initWithCapacity:7];
        [week30 addObject:(Day *)[[Day alloc] initWithParams:22 month:7]];
        [week30 addObject:(Day *)[[Day alloc] initWithParams:23 month:7]];
        [week30 addObject:(Day *)[[Day alloc] initWithParams:24 month:7]];
        [week30 addObject:(Day *)[[Day alloc] initWithParams:25 month:7]];
        [week30 addObject:(Day *)[[Day alloc] initWithParams:26 month:7]];
        [week30 addObject:(Day *)[[Day alloc] initWithParams:27 month:7]];
        [week30 addObject:(Day *)[[Day alloc] initWithParams:28 month:7]];
        Week *w30 = [[Week alloc] initWithParams:30 days:week30];
        [weeks addObject:w30];
        
        
        NSMutableArray *week31 =[[NSMutableArray alloc] initWithCapacity:7];
        [week31 addObject:(Day *)[[Day alloc] initWithParams:29 month:7]];
        [week31 addObject:(Day *)[[Day alloc] initWithParams:30 month:7]];
        [week31 addObject:(Day *)[[Day alloc] initWithParams:31 month:7]];
        [week31 addObject:(Day *)[[Day alloc] initWithParams:1 month:8]];
        [week31 addObject:(Day *)[[Day alloc] initWithParams:2 month:8]];
        [week31 addObject:(Day *)[[Day alloc] initWithParams:3 month:8]];
        [week31 addObject:(Day *)[[Day alloc] initWithParams:4 month:8]];
        Week *w31 = [[Week alloc] initWithParams:31 days:week31];
        [weeks addObject:w31];
        
        
        NSMutableArray *week32 =[[NSMutableArray alloc] initWithCapacity:7];
        [week32 addObject:(Day *)[[Day alloc] initWithParams:5 month:8]];
        [week32 addObject:(Day *)[[Day alloc] initWithParams:6 month:8]];
        [week32 addObject:(Day *)[[Day alloc] initWithParams:7 month:8]];
        [week32 addObject:(Day *)[[Day alloc] initWithParams:8 month:8]];
        [week32 addObject:(Day *)[[Day alloc] initWithParams:9 month:8]];
        [week32 addObject:(Day *)[[Day alloc] initWithParams:10 month:8]];
        [week32 addObject:(Day *)[[Day alloc] initWithParams:11 month:8]];
        Week *w32 = [[Week alloc] initWithParams:32 days:week32];
        [weeks addObject:w32];
        
        
        NSMutableArray *week33 =[[NSMutableArray alloc] initWithCapacity:7];
        [week33 addObject:(Day *)[[Day alloc] initWithParams:12 month:8]];
        [week33 addObject:(Day *)[[Day alloc] initWithParams:13 month:8]];
        [week33 addObject:(Day *)[[Day alloc] initWithParams:14 month:8]];
        [week33 addObject:(Day *)[[Day alloc] initWithParams:15 month:8]];
        [week33 addObject:(Day *)[[Day alloc] initWithParams:16 month:8]];
        [week33 addObject:(Day *)[[Day alloc] initWithParams:17 month:8]];
        [week33 addObject:(Day *)[[Day alloc] initWithParams:18 month:8]];
        Week *w33 = [[Week alloc] initWithParams:33 days:week33];
        [weeks addObject:w33];
        
        
        NSMutableArray *week34 =[[NSMutableArray alloc] initWithCapacity:7];
        [week34 addObject:(Day *)[[Day alloc] initWithParams:19 month:8]];
        [week34 addObject:(Day *)[[Day alloc] initWithParams:20 month:8]];
        [week34 addObject:(Day *)[[Day alloc] initWithParams:21 month:8]];
        [week34 addObject:(Day *)[[Day alloc] initWithParams:22 month:8]];
        [week34 addObject:(Day *)[[Day alloc] initWithParams:23 month:8]];
        [week34 addObject:(Day *)[[Day alloc] initWithParams:24 month:8]];
        [week34 addObject:(Day *)[[Day alloc] initWithParams:25 month:8]];
        Week *w34 = [[Week alloc] initWithParams:34 days:week34];
        [weeks addObject:w34];
        
        
        NSMutableArray *week35 =[[NSMutableArray alloc] initWithCapacity:7];
        [week35 addObject:(Day *)[[Day alloc] initWithParams:26 month:8]];
        [week35 addObject:(Day *)[[Day alloc] initWithParams:27 month:8]];
        [week35 addObject:(Day *)[[Day alloc] initWithParams:28 month:8]];
        [week35 addObject:(Day *)[[Day alloc] initWithParams:29 month:8]];
        [week35 addObject:(Day *)[[Day alloc] initWithParams:30 month:8]];
        [week35 addObject:(Day *)[[Day alloc] initWithParams:31 month:8]];
        [week35 addObject:(Day *)[[Day alloc] initWithParams:1 month:9]];
        Week *w35 = [[Week alloc] initWithParams:35 days:week35];
        [weeks addObject:w35];
        
        
        NSMutableArray *week36 =[[NSMutableArray alloc] initWithCapacity:7];
        [week36 addObject:(Day *)[[Day alloc] initWithParams:2 month:9]];
        [week36 addObject:(Day *)[[Day alloc] initWithParams:3 month:9]];
        [week36 addObject:(Day *)[[Day alloc] initWithParams:4 month:9]];
        [week36 addObject:(Day *)[[Day alloc] initWithParams:5 month:9]];
        [week36 addObject:(Day *)[[Day alloc] initWithParams:6 month:9]];
        [week36 addObject:(Day *)[[Day alloc] initWithParams:7 month:9]];
        [week36 addObject:(Day *)[[Day alloc] initWithParams:8 month:9]];
        Week *w36 = [[Week alloc] initWithParams:36 days:week36];
        [weeks addObject:w36];
        
        
        NSMutableArray *week37 =[[NSMutableArray alloc] initWithCapacity:7];
        [week37 addObject:(Day *)[[Day alloc] initWithParams:9 month:9]];
        [week37 addObject:(Day *)[[Day alloc] initWithParams:10 month:9]];
        [week37 addObject:(Day *)[[Day alloc] initWithParams:11 month:9]];
        [week37 addObject:(Day *)[[Day alloc] initWithParams:12 month:9]];
        [week37 addObject:(Day *)[[Day alloc] initWithParams:13 month:9]];
        [week37 addObject:(Day *)[[Day alloc] initWithParams:14 month:9]];
        [week37 addObject:(Day *)[[Day alloc] initWithParams:15 month:9]];
        Week *w37 = [[Week alloc] initWithParams:37 days:week37];
        [weeks addObject:w37];
        
        
        NSMutableArray *week38 =[[NSMutableArray alloc] initWithCapacity:7];
        [week38 addObject:(Day *)[[Day alloc] initWithParams:16 month:9]];
        [week38 addObject:(Day *)[[Day alloc] initWithParams:17 month:9]];
        [week38 addObject:(Day *)[[Day alloc] initWithParams:18 month:9]];
        [week38 addObject:(Day *)[[Day alloc] initWithParams:19 month:9]];
        [week38 addObject:(Day *)[[Day alloc] initWithParams:20 month:9]];
        [week38 addObject:(Day *)[[Day alloc] initWithParams:21 month:9]];
        [week38 addObject:(Day *)[[Day alloc] initWithParams:22 month:9]];
        Week *w38 = [[Week alloc] initWithParams:38 days:week38];
        [weeks addObject:w38];
        
        
        NSMutableArray *week39 =[[NSMutableArray alloc] initWithCapacity:7];
        [week39 addObject:(Day *)[[Day alloc] initWithParams:23 month:9]];
        [week39 addObject:(Day *)[[Day alloc] initWithParams:24 month:9]];
        [week39 addObject:(Day *)[[Day alloc] initWithParams:25 month:9]];
        [week39 addObject:(Day *)[[Day alloc] initWithParams:26 month:9]];
        [week39 addObject:(Day *)[[Day alloc] initWithParams:27 month:9]];
        [week39 addObject:(Day *)[[Day alloc] initWithParams:28 month:9]];
        [week39 addObject:(Day *)[[Day alloc] initWithParams:29 month:9]];
        Week *w39 = [[Week alloc] initWithParams:39 days:week39];
        [weeks addObject:w39];
        
        
        NSMutableArray *week40 =[[NSMutableArray alloc] initWithCapacity:7];
        [week40 addObject:(Day *)[[Day alloc] initWithParams:30 month:9]];
        [week40 addObject:(Day *)[[Day alloc] initWithParams:1 month:10]];
        [week40 addObject:(Day *)[[Day alloc] initWithParams:2 month:10]];
        [week40 addObject:(Day *)[[Day alloc] initWithParams:3 month:10]];
        [week40 addObject:(Day *)[[Day alloc] initWithParams:4 month:10]];
        [week40 addObject:(Day *)[[Day alloc] initWithParams:5 month:10]];
        [week40 addObject:(Day *)[[Day alloc] initWithParams:6 month:10]];
        Week *w40 = [[Week alloc] initWithParams:40 days:week40];
        [weeks addObject:w40];
        
        
        NSMutableArray *week41 =[[NSMutableArray alloc] initWithCapacity:7];
        [week41 addObject:(Day *)[[Day alloc] initWithParams:7 month:10]];
        [week41 addObject:(Day *)[[Day alloc] initWithParams:8 month:10]];
        [week41 addObject:(Day *)[[Day alloc] initWithParams:9 month:10]];
        [week41 addObject:(Day *)[[Day alloc] initWithParams:10 month:10]];
        [week41 addObject:(Day *)[[Day alloc] initWithParams:11 month:10]];
        [week41 addObject:(Day *)[[Day alloc] initWithParams:12 month:10]];
        [week41 addObject:(Day *)[[Day alloc] initWithParams:13 month:10]];
        Week *w41 = [[Week alloc] initWithParams:41 days:week41];
        [weeks addObject:w41];
        
        
        NSMutableArray *week42 =[[NSMutableArray alloc] initWithCapacity:7];
        [week42 addObject:(Day *)[[Day alloc] initWithParams:14 month:10]];
        [week42 addObject:(Day *)[[Day alloc] initWithParams:15 month:10]];
        [week42 addObject:(Day *)[[Day alloc] initWithParams:16 month:10]];
        [week42 addObject:(Day *)[[Day alloc] initWithParams:17 month:10]];
        [week42 addObject:(Day *)[[Day alloc] initWithParams:18 month:10]];
        [week42 addObject:(Day *)[[Day alloc] initWithParams:19 month:10]];
        [week42 addObject:(Day *)[[Day alloc] initWithParams:20 month:10]];
        Week *w42 = [[Week alloc] initWithParams:42 days:week42];
        [weeks addObject:w42];
        
        
        NSMutableArray *week43 =[[NSMutableArray alloc] initWithCapacity:7];
        [week43 addObject:(Day *)[[Day alloc] initWithParams:21 month:10]];
        [week43 addObject:(Day *)[[Day alloc] initWithParams:22 month:10]];
        [week43 addObject:(Day *)[[Day alloc] initWithParams:23 month:10]];
        [week43 addObject:(Day *)[[Day alloc] initWithParams:24 month:10]];
        [week43 addObject:(Day *)[[Day alloc] initWithParams:25 month:10]];
        [week43 addObject:(Day *)[[Day alloc] initWithParams:26 month:10]];
        [week43 addObject:(Day *)[[Day alloc] initWithParams:27 month:10]];
        Week *w43 = [[Week alloc] initWithParams:43 days:week43];
        [weeks addObject:w43];
        
        
        NSMutableArray *week44 =[[NSMutableArray alloc] initWithCapacity:7];
        [week44 addObject:(Day *)[[Day alloc] initWithParams:28 month:10]];
        [week44 addObject:(Day *)[[Day alloc] initWithParams:29 month:10]];
        [week44 addObject:(Day *)[[Day alloc] initWithParams:30 month:10]];
        [week44 addObject:(Day *)[[Day alloc] initWithParams:31 month:10]];
        [week44 addObject:(Day *)[[Day alloc] initWithParams:1 month:11]];
        [week44 addObject:(Day *)[[Day alloc] initWithParams:2 month:11]];
        [week44 addObject:(Day *)[[Day alloc] initWithParams:3 month:11]];
        Week *w44 = [[Week alloc] initWithParams:44 days:week44];
        [weeks addObject:w44];
        
        
        NSMutableArray *week45 =[[NSMutableArray alloc] initWithCapacity:7];
        [week45 addObject:(Day *)[[Day alloc] initWithParams:4 month:11]];
        [week45 addObject:(Day *)[[Day alloc] initWithParams:5 month:11]];
        [week45 addObject:(Day *)[[Day alloc] initWithParams:6 month:11]];
        [week45 addObject:(Day *)[[Day alloc] initWithParams:7 month:11]];
        [week45 addObject:(Day *)[[Day alloc] initWithParams:8 month:11]];
        [week45 addObject:(Day *)[[Day alloc] initWithParams:9 month:11]];
        [week45 addObject:(Day *)[[Day alloc] initWithParams:10 month:11]];
        Week *w45 = [[Week alloc] initWithParams:45 days:week45];
        [weeks addObject:w45];
        
        
        NSMutableArray *week46 =[[NSMutableArray alloc] initWithCapacity:7];
        [week46 addObject:(Day *)[[Day alloc] initWithParams:11 month:11]];
        [week46 addObject:(Day *)[[Day alloc] initWithParams:12 month:11]];
        [week46 addObject:(Day *)[[Day alloc] initWithParams:13 month:11]];
        [week46 addObject:(Day *)[[Day alloc] initWithParams:14 month:11]];
        [week46 addObject:(Day *)[[Day alloc] initWithParams:15 month:11]];
        [week46 addObject:(Day *)[[Day alloc] initWithParams:16 month:11]];
        [week46 addObject:(Day *)[[Day alloc] initWithParams:17 month:11]];
        Week *w46 = [[Week alloc] initWithParams:46 days:week46];
        [weeks addObject:w46];
        
        
        NSMutableArray *week47 =[[NSMutableArray alloc] initWithCapacity:7];
        [week47 addObject:(Day *)[[Day alloc] initWithParams:18 month:11]];
        [week47 addObject:(Day *)[[Day alloc] initWithParams:19 month:11]];
        [week47 addObject:(Day *)[[Day alloc] initWithParams:20 month:11]];
        [week47 addObject:(Day *)[[Day alloc] initWithParams:21 month:11]];
        [week47 addObject:(Day *)[[Day alloc] initWithParams:22 month:11]];
        [week47 addObject:(Day *)[[Day alloc] initWithParams:23 month:11]];
        [week47 addObject:(Day *)[[Day alloc] initWithParams:24 month:11]];
        Week *w47 = [[Week alloc] initWithParams:47 days:week47];
        [weeks addObject:w47];
        
        
        NSMutableArray *week48 =[[NSMutableArray alloc] initWithCapacity:7];
        [week48 addObject:(Day *)[[Day alloc] initWithParams:25 month:11]];
        [week48 addObject:(Day *)[[Day alloc] initWithParams:26 month:11]];
        [week48 addObject:(Day *)[[Day alloc] initWithParams:27 month:11]];
        [week48 addObject:(Day *)[[Day alloc] initWithParams:28 month:11]];
        [week48 addObject:(Day *)[[Day alloc] initWithParams:29 month:11]];
        [week48 addObject:(Day *)[[Day alloc] initWithParams:30 month:11]];
        [week48 addObject:(Day *)[[Day alloc] initWithParams:1 month:12]];
        Week *w48 = [[Week alloc] initWithParams:48 days:week48];
        [weeks addObject:w48];
        
        
        NSMutableArray *week49 =[[NSMutableArray alloc] initWithCapacity:7];
        [week49 addObject:(Day *)[[Day alloc] initWithParams:2 month:12]];
        [week49 addObject:(Day *)[[Day alloc] initWithParams:3 month:12]];
        [week49 addObject:(Day *)[[Day alloc] initWithParams:4 month:12]];
        [week49 addObject:(Day *)[[Day alloc] initWithParams:5 month:12]];
        [week49 addObject:(Day *)[[Day alloc] initWithParams:6 month:12]];
        [week49 addObject:(Day *)[[Day alloc] initWithParams:7 month:12]];
        [week49 addObject:(Day *)[[Day alloc] initWithParams:8 month:12]];
        Week *w49 = [[Week alloc] initWithParams:49 days:week49];
        [weeks addObject:w49];
        
        
        NSMutableArray *week50 =[[NSMutableArray alloc] initWithCapacity:7];
        [week50 addObject:(Day *)[[Day alloc] initWithParams:9 month:12]];
        [week50 addObject:(Day *)[[Day alloc] initWithParams:10 month:12]];
        [week50 addObject:(Day *)[[Day alloc] initWithParams:11 month:12]];
        [week50 addObject:(Day *)[[Day alloc] initWithParams:12 month:12]];
        [week50 addObject:(Day *)[[Day alloc] initWithParams:13 month:12]];
        [week50 addObject:(Day *)[[Day alloc] initWithParams:14 month:12]];
        [week50 addObject:(Day *)[[Day alloc] initWithParams:15 month:12]];
        Week *w50 = [[Week alloc] initWithParams:50 days:week50];
        [weeks addObject:w50];
        
        
        NSMutableArray *week51 =[[NSMutableArray alloc] initWithCapacity:7];
        [week51 addObject:(Day *)[[Day alloc] initWithParams:16 month:12]];
        [week51 addObject:(Day *)[[Day alloc] initWithParams:17 month:12]];
        [week51 addObject:(Day *)[[Day alloc] initWithParams:18 month:12]];
        [week51 addObject:(Day *)[[Day alloc] initWithParams:19 month:12]];
        [week51 addObject:(Day *)[[Day alloc] initWithParams:20 month:12]];
        [week51 addObject:(Day *)[[Day alloc] initWithParams:21 month:12]];
        [week51 addObject:(Day *)[[Day alloc] initWithParams:22 month:12]];
        Week *w51 = [[Week alloc] initWithParams:51 days:week51];
        [weeks addObject:w51];
        
        
        NSMutableArray *week52 =[[NSMutableArray alloc] initWithCapacity:7];
        [week52 addObject:(Day *)[[Day alloc] initWithParams:23 month:12]];
        [week52 addObject:(Day *)[[Day alloc] initWithParams:24 month:12]];
        [week52 addObject:(Day *)[[Day alloc] initWithParams:25 month:12]];
        [week52 addObject:(Day *)[[Day alloc] initWithParams:26 month:12]];
        [week52 addObject:(Day *)[[Day alloc] initWithParams:27 month:12]];
        [week52 addObject:(Day *)[[Day alloc] initWithParams:28 month:12]];
        [week52 addObject:(Day *)[[Day alloc] initWithParams:29 month:12]];
        Week *w52 = [[Week alloc] initWithParams:52 days:week52];
        [weeks addObject:w52];
        
        NSMutableArray *week53 =[[NSMutableArray alloc] initWithCapacity:2];
        [week53 addObject:(Day *)[[Day alloc] initWithParams:30 month:12]];
        [week53 addObject:(Day *)[[Day alloc] initWithParams:31 month:12]];
        Week *w53 = [[Week alloc] initWithParams:53 days:week53];
        [weeks addObject:w53];
         
	}
    
	return self;    
    
}
*/

- (id) initWithYear:(NSNumber *)year {

	self = [super init];

	if(self){
		// initialize here
		self->year = year;
        self->weeks = [[NSMutableArray alloc] initWithCapacity:54];
		[Calendar populateCalendar:weeks currentYear:self->year];

	}
    
	return self;

}

+ (void) populateCalendar:(NSMutableArray *) weeks currentYear:(NSNumber *)year{
    
    NSMutableArray *week;
    
	for(int i = 0; i < 54; i++){

        week =[[NSMutableArray alloc] initWithCapacity:7];
        
        Week *w = [[Week alloc] initWithParams:i];
        [weeks addObject:w];

	}


}


@end
