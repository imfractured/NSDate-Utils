//
//  NSDate+Utils.m
//  cal
//
//  Created by Nick Gorman on 2014-08-21.
//  Copyright (c) 2014 Nick Gorman. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)

@dynamic isEnabled;

static const unsigned componentFlags = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit);

- (void)setIsEnabled:(id)isEnabled {
    objc_setAssociatedObject(self, @selector(isEnabled), isEnabled, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)isEnabled {
    return objc_getAssociatedObject(self, @selector(isEnabled));
}

+(NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    return [calendar dateFromComponents:components];
}

+(NSDate*)dateWithDaysBeforeNow:(NSInteger)days {
    return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateWithDaysFromNow:(NSInteger)days {
    return [[NSDate date] dateByAddingDays:days];
}

+(NSDate*)dateTomorrow {
    return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *) dateYesterday {
    return [NSDate dateWithDaysBeforeNow:1];
}

-(BOOL)isFuture {
    BOOL isInFuture = ([self compare:[NSDate date]] == NSOrderedDescending);
    return isInFuture;
}

-(BOOL)isToday {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components1 = [gregorian components:componentFlags fromDate:self];
    NSDateComponents *components2 = [gregorian components:componentFlags fromDate:[NSDate date]];
    return ((components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day));
}

-(BOOL)isSameMonthAsDate: (NSDate *) aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components1 = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) && (components1.year == components2.year));
}

-(BOOL)isThisMonth {
    return [self isSameMonthAsDate:[NSDate date]];
}

-(BOOL)isLastMonth {
    return [self isSameMonthAsDate:[[NSDate date] dateBySubtractingMonths:1]];
}

-(BOOL)isNextMonth {
    return [self isSameMonthAsDate:[[NSDate date] dateByAddingMonths:1]];
}

-(BOOL)isSameYearAsDate:(NSDate*) aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components1 = [gregorian components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSYearCalendarUnit fromDate:aDate];
    return (components1.year == components2.year);
}

-(BOOL)isThisYear {
    return [self isSameYearAsDate:[NSDate date]];
}

-(BOOL)isNextYear {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components1 = [gregorian components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
    return (components1.year == (components2.year + 1));
}

-(BOOL)isLastYear {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components1 = [gregorian components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
    return (components1.year == (components2.year - 1));
}

-(BOOL)isEarlierThanDate:(NSDate*) aDate {
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate*) aDate {
    return ([self compare:aDate] == NSOrderedDescending);
}

-(BOOL)isEqualToDateIgnoringTime:(NSDate*)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components1 = [gregorian components:componentFlags fromDate:self];
    NSDateComponents *components2 = [gregorian components:componentFlags fromDate:aDate];
    return ((components1.year == components2.year) && (components1.month == components2.month) && (components1.day == components2.day));
}

-(BOOL)isSameWeekAsDate:(NSDate *) aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components1 = [gregorian components:componentFlags fromDate:self];
    NSDateComponents *components2 = [gregorian components:componentFlags fromDate:aDate];
    if (components1.weekOfYear != components2.weekOfYear) return NO;
    return (abs([self timeIntervalSinceDate:aDate]) < 604800); // seconds in week
}

-(BOOL)isThisWeek {
    return [self isSameWeekAsDate:[NSDate date]];
}

-(BOOL)isNextWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + 604800; // seconds in week
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}

-(BOOL)isLastWeek {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - 604800; // seconds in week
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self isSameWeekAsDate:newDate];
}



-(int)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

-(int)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

-(int)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

-(NSString*)description {
    NSString *desc = [[NSString alloc] initWithFormat:@"%@ %i, %i",[self monthString],[self day],[self year]];
    return desc;
}

-(NSString*)dayOfWeek {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    return [_daysOfWeek objectAtIndex:[components weekday]-1];
}

-(NSString*)dayOfWeekShort {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:componentFlags fromDate:self];
    NSRange firstThree = NSMakeRange(0, 3);
    return [[_daysOfWeek objectAtIndex:[components weekday]-1] substringWithRange:firstThree];
}

-(NSString*)monthString {
    return [_months objectAtIndex:[self month]-1];
}

-(NSString*)stringWithFormat:(NSString*)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

-(NSDate*)dateByAddingDays:(int)numberOfDays {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setDay:numberOfDays];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

-(NSDate*)dateBySubtractingDays:(int)numberOfDays {
    return [self dateByAddingDays: (numberOfDays * -1)];
}

-(NSDate*)dateByAddingMonths:(int)numberOfMonths {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setMonth:numberOfMonths];
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
    return newDate;
}

-(NSDate*)dateBySubtractingMonths:(int)numberOfMonths {
    return [self dateByAddingMonths:(numberOfMonths * -1)];
}

@end
