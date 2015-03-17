//
//  JTCalendarDataSource.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@class JTCalendar;

@protocol JTCalendarDataSource <NSObject>

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date;
- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date;

@optional
- (void)calendarDidLoadPreviousPage;
- (void)calendarDidLoadNextPage;

- (void)calendarDidLoadPreviousPage:(NSDate *)date;
- (void)calendarDidLoadNextPage:(NSDate *)date;

@end
