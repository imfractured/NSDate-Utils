//
//  NSDate+Utils.h
//  cal
//
//  Created by Nick Gorman on 2014-08-21.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#define _months      [NSArray arrayWithObjects: @"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December",nil]
#define _daysOfWeek  [NSArray arrayWithObjects: @"Sunday",@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",nil]

@interface NSDate (Utils)

@property (nonatomic, strong) id isEnabled;

+(NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+(NSDate*)dateWithDaysBeforeNow:(NSInteger)days;
+(NSDate*)dateWithDaysFromNow:(NSInteger)days;
+(NSDate*)dateTomorrow;
+(NSDate*)dateYesterday;

-(NSDate*)dateByAddingDays:(int)numberOfDays;
-(NSDate*)dateBySubtractingDays:(int)numberOfDays;
-(NSDate*)dateByAddingMonths:(int)numberOfMonths;
-(NSDate*)dateBySubtractingMonths:(int)numberOfMonths;

-(int)day;
-(int)month;
-(int)year;

-(BOOL)isFuture;
-(BOOL)isToday;
-(BOOL)isThisMonth;
-(BOOL)isLastMonth;
-(BOOL)isNextMonth;
-(BOOL)isThisWeek;
-(BOOL)isNextWeek;
-(BOOL)isLastWeek;
-(BOOL)isThisYear;
-(BOOL)isNextYear;
-(BOOL)isLastYear;

-(BOOL)isSameMonthAsDate:(NSDate*) aDate;
-(BOOL)isSameWeekAsDate:(NSDate*) aDate;
-(BOOL)isSameYearAsDate:(NSDate*) aDate;
-(BOOL)isEarlierThanDate:(NSDate*) aDate;
-(BOOL)isLaterThanDate:(NSDate*) aDate;
-(BOOL)isEqualToDateIgnoringTime:(NSDate*) aDate;

-(NSString*)dayOfWeek;
-(NSString*)dayOfWeekShort;
-(NSString*)monthString;
-(NSString*)description;
-(NSString*)stringWithFormat:(NSString*)format;


@end
