//
//  NSNumber+AXTool.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/1/3.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (AXTool)

/**
 将数字 整数部分转为每隔3位整数由","分隔,小数部分不变的 千分位 字符串
 使用NumberFarmatt
 @return string
 */
- (NSString *)ax_numberToThousands;

/**
 解决 精度失真
 这个方法会舍弃多余的0
 @return string
 */
- (NSString *)ax_description;

@end
