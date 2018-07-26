//
//  NSDateComponents+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 2017/1/5.
//  Copyright © 2017年 liuweixing All rights reserved.
//

#import "NSDateComponents+AXTool.h"

@implementation NSDateComponents (AXTool)

/**
 * 当前系统时间 日历格式
 */
+ (instancetype )ax_currentDateComponents{

    NSDate *date = [[NSDate alloc]init];
    NSInteger interval = [[NSTimeZone defaultTimeZone] secondsFromGMTForDate: date];
    date = [date  dateByAddingTimeInterval: interval];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:( NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  | NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond) fromDate:date];
//    NSDateComponents *components = [calendar componentsInTimeZone:[NSTimeZone defaultTimeZone] fromDate:date]
    components.calendar = calendar;
    return components;
    
}
@end
