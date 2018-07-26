//
//  NSDate+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/3/29.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSDate+AXTool.h"

@implementation NSDate (AXTool)

/**
 * NSDate转换NSString
 yyyyMMddHHmmss
 yyyy年MM月dd日 HH:mm:ss
 yyyy-MM-dd HH:mm:ss
 yyyyMMdd
 yyyy年MM月dd日
 */
- (NSString *)ax_toStringWithFormatter:(NSString *)formatter{

    NSDateFormatter *dateshowFormatter = [[NSDateFormatter alloc] init];
    dateshowFormatter.dateFormat = formatter;
    NSString *dateString = [dateshowFormatter stringFromDate:self];
    return dateString;
}


/**
 * 和当前时间对比,年月日哪个不同  0年月日相同 1 年不同 2月不同 3日不同
 */
- (NSInteger)ax_differToNowDate{

    NSDate *nowDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: nowDate];
    nowDate = [nowDate  dateByAddingTimeInterval: interval];
    
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    //年月日
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *nowComponents = [cal components:unitFlags fromDate:nowDate];
    
     NSDateComponents *toComponents = [cal components:unitFlags fromDate:self];
    
    NSInteger differ = 0;
    if (nowComponents.year == toComponents.year) {
        differ = 1;
        if (nowComponents.month == toComponents.month){
            differ = 2;
            if (nowComponents.day == toComponents.day){
                differ = 3;
            }
        }
        
    }
    
 
    return differ;
}


/**
 *  当前系统时间显示为字符串
 yyyyMMddHHmmss
 yyyy年MM月dd日 HH:mm:ss
 yyyy-MM-dd HH:mm:ss
 yyyyMMdd
 yyyy年MM月dd日
 */
+(NSString *)ax_nowDateToStringFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}


/**
 当天时间,获得 相距  年月日 日历

 @param year 相距  年
 @param month 相距  月
 @param day 相距  日
 @return NSDate 获得的时间
 */
+(NSDate *)ax_currentDateApartToYear:(NSInteger )year month:(NSInteger )month day:(NSInteger )day{

    NSDate *todayDate  = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:todayDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    adcomps.year = year;
    adcomps.month = month;
    adcomps.day = day;
    
    return [calendar dateByAddingComponents:adcomps toDate:todayDate options:0];
}

/**
 当前时间,获得 相距 年月日 日历
 
 @param year 相距  年
 @param month 相距  月
 @param day 相距  日
 @return NSDate 获得的时间
 */
- (NSDate *)ax_dateApartToYear:(NSInteger )year month:(NSInteger )month day:(NSInteger )day{
    
    NSDate *todayDate  = self;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:todayDate];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    adcomps.year = year;
    adcomps.month = month;
    adcomps.day = day;
    
    return [calendar dateByAddingComponents:adcomps toDate:todayDate options:0];
}

@end
