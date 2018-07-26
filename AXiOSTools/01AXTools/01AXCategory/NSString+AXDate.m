//
//  NSString+AXDate.m
//  AXiOSTools
//
//  Created by liuweixing on 2016/12/26.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSString+AXDate.h"
#import "NSString+AXTool.h"
@implementation NSString (AXDate)
/**
 时间字符串,转换成指定格式的时间字符串
 
 @param currentformat 当前格式
 @param toformatter 需要转换的格式
 @return 时间字符串
 */
- (NSString *)ax_toChangeTpyeCurrentFormat:(NSString *)currentformat toFormatter:(NSString *)toformatter{
    
    NSString *time = self;
    
    if (time.length>currentformat.length) {
        
       time = [time substringToIndex:currentformat.length];
        
    }else if (time.length<currentformat.length){
        
        NSUInteger more = currentformat.length-time.length;
        
        for (int index=0; index<more; index++) {
             time = [NSString stringWithFormat:@"%@0",time];
        }
    }
    
    NSDate *localeDate =  [time ax_toDateWithFormat:currentformat];
    
    return [localeDate ax_toStringWithFormatter:toformatter];
    
}

/**
 * 时间字符串拼接成显示状态,0-> xxxx年x月x日 1-> xxxx-x- x
 */
- (NSString *)ax_dateStringWithState:(NSInteger )state{
    NSString *str = [self substringToIndex:14];
    
    NSString *yearStr = [str substringToIndex:4];
    
    NSString *monethStr = [str substringWithRange:NSMakeRange(4, 2)];
    
    NSString *dateStr = [str substringWithRange:NSMakeRange(6, 2)];
    
    NSString *timeStr = nil;
    switch (state) {
        case 0:
            return timeStr = [NSString stringWithFormat:@"%@年%@月%@日",yearStr,monethStr,dateStr];
            break;
            
        default:
            return   timeStr = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monethStr,dateStr];
            break;
    }
}

/**
 *  当前系统时间显示为字符串
 yyyyMMddHHmmss
 yyyy年MM月dd日 HH:mm:ss
 yyyy-MM-dd HH:mm:ss
 yyyyMMdd
 yyyy年MM月dd日
 */
+(NSString *)ax_stringNowDateFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatter;
    
    NSString *dateStr = [dateFormatter stringFromDate:[NSDate date]];
    return dateStr;
}

/**
 时间字符串转换成本地时区时间,格式必须与需要转化的格式一致
 
 @param format 当前字符串时间样式
 @return 返回时间
 */
- (NSDate *)ax_toDateWithFormat:(NSString *)format{
    
    NSString *timeStr = self;
    
    if (timeStr.length>0 && timeStr.length != format.length) {
         NSLog(@"时间字符串转换成本地时区时间,格式与需要转化的格式不一致");
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = format;
    dateFormatter.timeZone = [NSTimeZone localTimeZone];
    
    NSDate *localeDate = [dateFormatter dateFromString:timeStr];
    
    return localeDate;
}

/**
 * 时间戳转换成时间格式(时间戳为10精确秒 或者 13位精确毫秒,自动补齐)
 */
- (NSString *)ax_timeStampToStringFormat:(NSString *)format{
    
    NSString *time = self;
    
    if (time.length>13) {
        
       time = [time substringFromIndex:12];
        
    }else if (time.length<13){
        
        NSInteger count = 13-time.length;
        
        for (NSInteger index=0; index<count; index++) {
            
             time = [time stringByAppendingString:@"0"];
        }
    }
    NSDate *date= [NSDate dateWithTimeIntervalSince1970: time.doubleValue/1000];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}

/**
 * 时间戳转换成时间格式(时间戳为10精确秒 或者 13位精确毫秒,自动补齐)
 yyyy-MM-dd HH:mm:ss 格式
 */
- (NSString *)ax_timeStampToStringDefault{
    
    return [self ax_timeStampToStringFormat:@"yyyy-MM-dd HH:mm:ss"];
}
/**
 * 时间戳转换成本地时区 Date (精确到秒,10位)
 */
- (NSDate *)ax_timestampToDate{
    NSString *time = self;
    if (time.length>10) {
        time = [time substringToIndex:10];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time.doubleValue];
    NSTimeZone *zone = [NSTimeZone localTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return  [date  dateByAddingTimeInterval: interval];
}


/**
 * 判断时间字符串与当前时间年月日是否相同
 */
- (NSString *)ax_differToNowDate{
    NSString *selfTime = self;
    //    if (selfTime.length<19) {
    //        NSInteger chaju = 19-selfTime.length;
    //
    //
    //    }
    NSDateFormatter *mattet = [NSDateFormatter new];
    mattet.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowDateStr = [mattet stringFromDate:[NSDate new]];
    
    NSString *nowyear =[nowDateStr substringToIndex:4];
    NSString *nowmonth =[nowDateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *nowday =[nowDateStr substringWithRange:NSMakeRange(8, 2)];
    
    
    NSString *toyear =[selfTime substringToIndex:4];
    NSString *tomonth =[selfTime substringWithRange:NSMakeRange(5, 2)];
    NSString *today =[selfTime substringWithRange:NSMakeRange(8, 2)];
    
    
    NSString * differ = selfTime;
    if (nowyear == toyear) {
        differ = [selfTime substringFromIndex:5];
        if (nowmonth == tomonth){
            differ = [selfTime substringFromIndex:5];;
            if (nowday == today){
                differ = [selfTime substringFromIndex:11];;
            }
        }
        
    }
    return differ;
}
@end
