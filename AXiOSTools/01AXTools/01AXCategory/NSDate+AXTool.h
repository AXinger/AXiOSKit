//
//  NSDate+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 16/3/29.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AXTool)

/**
 * NSDate转换NSString
 yyyyMMddHHmmss
 yyyy年MM月dd日 HH:mm:ss
 yyyy-MM-dd HH:mm:ss
 yyyyMMdd
 yyyy年MM月dd日
 */
- (NSString *)ax_toStringWithFormatter:(NSString *)formatter;

/**
 * 和当前时间对比,年月日哪个不同  0年月日相同 1 年不同 2月不同 3日不同
 */
- (NSInteger)ax_differToNowDate;


/**
 *  当前系统时间显示为字符串
 yyyyMMddHHmmss
 yyyy年MM月dd日 HH:mm:ss
 yyyy-MM-dd HH:mm:ss
 yyyyMMdd
 yyyy年MM月dd日
 */
+(NSString *)ax_nowDateToStringFormatter:(NSString *)formatter;

/**
 当天时间,获得 相距  年月日 日历
 
 @param year 相距  年
 @param month 相距  月
 @param day 相距  日
 @return NSDate 获得的时间
 */
+(NSDate *)ax_currentDateApartToYear:(NSInteger )year month:(NSInteger )month day:(NSInteger )day;
/**
 当前时间,获得 相距 年月日 日历
 
 @param year 相距  年
 @param month 相距  月
 @param day 相距  日
 @return NSDate 获得的时间
 */
- (NSDate *)ax_dateApartToYear:(NSInteger )year month:(NSInteger )month day:(NSInteger )day;

@end
