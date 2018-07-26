//
//  NSString+AXDate.h
//  AXiOSTools
//
//  Created by liuweixing on 2016/12/26.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AXDate)

/**
 时间字符串,改变成其他指定格式的时间字符串
 
 @param currentformat 当前格式
 @param toformatter 需要转换的格式
 @return 时间字符串
 */
- (NSString *)ax_toChangeTpyeCurrentFormat:(NSString *)currentformat toFormatter:(NSString *)toformatter;

/**
 当前系统时间显示为字符串
 yyyyMMddHHmmss
 yyyy年MM月dd日 HH:mm:ss
 yyyyMMdd
 yyyy年MM月dd日
 
 @param formatter formatter description
 @return return value description
 */
+(NSString *)ax_stringNowDateFormatter:(NSString *)formatter;

/**
 时间字符串转换成本地时区时间,格式必须与需要转化的格式一致
 
 @param format 当前字符串时间样式
 @return 返回时间
 */
- (NSDate *)ax_toDateWithFormat:(NSString *)format;

/**
 * 时间戳转换成时间格式(时间戳为10精确秒 或者 13位精确毫秒,自动补齐)
 */
- (NSString *)ax_timeStampToStringFormat:(NSString *)format;

/**
 * 时间戳转换成时间格式(时间戳为10精确秒 或者 13位精确毫秒,自动补齐)
  默认 yyyy-MM-dd HH:mm:ss 格式
 */
- (NSString *)ax_timeStampToStringDefault;

/**
 * 时间戳转换成本地时区 Date (精确到秒,10位)
 */
- (NSDate *)ax_timestampToDate;

/**
 判断时间字符串与当前时间年月日是否相同
 
 @return 返回不一样的部分
 */
- (NSString *)ax_differToNowDate;


@end
