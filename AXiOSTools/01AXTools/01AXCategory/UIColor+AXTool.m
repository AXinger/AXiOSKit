//
//  UIColor+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/6/3.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "UIColor+AXTool.h"

@implementation UIColor (AXTool)



/**
 * 输入16进制颜色 格式为: 0xaabbcc
 */
+(UIColor *)ax_colorFromHexInt:(int)rgbValue{
    float read = ((float)((rgbValue & 0xFF0000) >> 16))/255.0;
    float green = ((float)((rgbValue & 0xFF00) >> 8))/255.0;
    float blue = ((float)(rgbValue & 0xFF))/255.0;
    return  [UIColor colorWithRed:read green:green blue:blue alpha:1];
}

/**
 * 输入16进制颜色 格式为: 0xaabbcc
 */
+(UIColor *)ax_colorFrom16RGB:(int)rgbValue{
    
    float read = ((float)((rgbValue & 0xFF0000) >> 16))/255.0;
    float green = ((float)((rgbValue & 0xFF00) >> 8))/255.0;
    float blue = ((float)(rgbValue & 0xFF))/255.0;
    return  [UIColor colorWithRed:read green:green blue:blue alpha:1];
}

/**
 * 输入16进制颜色 格式为: #aabbcc
 */
+(UIColor *)ax_colorFrom16RGBString:(NSString *)string{
    //删除字符串中的空格
    NSString *cString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] ==7 && [cString hasPrefix:@"#"]){
        ////如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        cString = [cString substringFromIndex:1];
    }else if ([cString length] ==8 && ([cString hasPrefix:@"0X"] ||[cString hasPrefix:@"0x"])){
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        cString = [cString substringFromIndex:2];
    }else{
        return [UIColor clearColor];
    }
    
    
    // Separate into r, g, b substrings
    //r
    NSString *rString = [cString substringWithRange:NSMakeRange(0, 2)];
    //g
    NSString *gString = [cString substringWithRange:NSMakeRange(2, 2)];
    //b
    NSString *bString = [cString substringWithRange:NSMakeRange(4, 2)];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1];
}

/**
 * 输入16进制颜色 格式为: #aabbcc
 */
+(UIColor *)ax_colorFromHexString:(NSString *)string{
    
    //删除字符串中的空格
    NSString *cString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] ==7 && [cString hasPrefix:@"#"]){
        ////如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
        cString = [cString substringFromIndex:1];
    }else if ([cString length] ==8 && ([cString hasPrefix:@"0X"] ||[cString hasPrefix:@"0x"])){
        //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
        cString = [cString substringFromIndex:2];
    }else{
        return [UIColor clearColor];
    }
    
    
    // Separate into r, g, b substrings
    //r
    NSString *rString = [cString substringWithRange:NSMakeRange(0, 2)];
    //g
    NSString *gString = [cString substringWithRange:NSMakeRange(2, 2)];
    //b
    NSString *bString = [cString substringWithRange:NSMakeRange(4, 2)];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1];
}

/**
 * 直接输入0~225的数字
 */
+(UIColor *)ax_colorRed:(int)r green:(int)g blue:(int)b{
    return  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
}

/**
 * 随机色
 */
+(UIColor *)ax_randomColor{
    
    CGFloat red = arc4random() % 256 / 256.0 ;
    
    CGFloat green = arc4random() % 256 / 256.0;
    
    CGFloat blue = arc4random() % 256 / 256.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}


/**
 UIColor 转 16进制

 @return #ffffff格式的字符串
 */
- (NSString *)ax_toHexString {
    
    UIColor *color = self;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    
    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}
@end
