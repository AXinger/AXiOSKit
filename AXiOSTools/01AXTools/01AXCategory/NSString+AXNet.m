//
//  NSString+AXNet.m
//  AXiOSTools
//
//  Created by liuweixing on 2016/12/2.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSString+AXNet.h"
#import "AXToolsHeader.h"
@implementation NSString (AXNet)
/**
 * 构建通用网关的请求 url，参数为键值对形式，不分顺序。不需要包含时间戳、签名等参数 ，系统会自动增加。
 *                  地址
 * @param key
 *                  加密的key
 * @param parameters
 *                  参数
 * @return  生成后的网关
 */
- (NSString *)buildUrlWihtKey:(NSString *)key parameters:(NSMutableDictionary *)parameters{
    NSString *baseUrl = self;
    if ([[parameters allKeys] containsObject:@"_s"] || [[parameters allKeys] containsObject:@"_t"]){
        NSLog(@"在使用 ShoveGeneralRestGateway buildUrl 方法构建通用 REST 接口 Url 时，不能使用 _s, _t 此保留字作为参数名。");
        return nil;
    }
    
    if (key.length==0) {
        NSLog(@"在使用 ShoveGeneralRestGateway buildUrl 方法构建通用 REST 接口 Url 时，必须提供一个用于摘要签名用的 key (俗称 MD5 加盐)。");
        return nil;
    }
    
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString* currentDate = [formatter stringFromDate:date];
    [parameters setValue:currentDate forKey:@"_t"];
    
    NSArray *parameterNames = [parameters allKeys];
    parameterNames = [parameterNames sortedArrayUsingSelector:@selector(compare:)];// 字符串编码升序排序
    
    if (![baseUrl hasSuffix:@"?"] && ![baseUrl hasSuffix:@"&"]) {
        if([baseUrl rangeOfString:@"?"].length <= 0)
        {
            baseUrl = [baseUrl stringByAppendingString:@"?"];
        } else {
            baseUrl = [baseUrl stringByAppendingString:@"&"];
        }
    }
    
    NSString *signStr = @"";
    
    for (int i = 0; i < parameters.count; i++) {
        
        NSString *_key = parameterNames[i];
        NSString * _value = parameters[_key];
        
        signStr = [NSString stringWithFormat:@"%@%@=%@", signStr, _key, _value];
        
        baseUrl = [NSString stringWithFormat:@"%@%@=%@", baseUrl, _key,  [_value.description stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
//        baseUrl = [NSString stringWithFormat:@"%@%@=%@", baseUrl, _key, [_value.description stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]; // 将value编码

        if (i < ([parameters count] - 1)) {
            signStr = [signStr stringByAppendingString:@"&"];
            baseUrl = [baseUrl stringByAppendingString:@"&"];
        }
    }
    baseUrl = [NSString stringWithFormat:@"%@&_s=%@", baseUrl, [[signStr stringByAppendingString:key] ax_MD5]];
    
    return baseUrl;
}

@end
