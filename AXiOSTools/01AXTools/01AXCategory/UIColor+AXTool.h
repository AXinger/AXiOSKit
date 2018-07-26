//
//  UIColor+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 16/6/3.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AXTool)

/**
 * 输入16进制颜色 格式为: 0xaabbcc
 */
+(UIColor *)ax_colorFrom16RGB:(int)rgbValue DEPRECATED_MSG_ATTRIBUTE ("过期,请使用 ax_colorFromHexInt: ");

/**
 * 输入16进制颜色 格式为: 0xaabbcc
 */
+(UIColor *)ax_colorFromHexInt:(int)rgbValue;

/**
 * 输入16进制颜色 格式为: #aabbcc
 */
+(UIColor *)ax_colorFrom16RGBString:(NSString *)string DEPRECATED_MSG_ATTRIBUTE ("过期,请使用 ax_colorFromHexString: ");

/**
 * 输入16进制颜色 格式为: #aabbcc
 */
+(UIColor *)ax_colorFromHexString:(NSString *)string;

/**
 * 直接输入0~225的数字
 */
+(UIColor *)ax_colorRed:(int)r green:(int)g blue:(int)b;

/**
 * 随机色
 */
+(UIColor *)ax_randomColor;

/**
 UIColor 转 16进制
 
 @return #ffffff格式的字符串
 */
- (NSString *)ax_toHexString;

@end
