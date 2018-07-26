//
//  NSString+AXNet.h
//  AXiOSTools
//
//  Created by liuweixing on 2016/12/2.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AXNet)

/**
 * 构建通用网关的请求 url，参数为键值对形式，不分顺序。不需要包含时间戳、签名等参数 ，系统会自动增加。
 * @param key
 *                  加密的key
 * @param parameters
 *                  参数
 * @return  生成后的网关
 */
- (NSString *)buildUrlWihtKey:(NSString *)key parameters:(NSMutableDictionary *)parameters;

@end
