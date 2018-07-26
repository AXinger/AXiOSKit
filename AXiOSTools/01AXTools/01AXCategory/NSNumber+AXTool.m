//
//  NSNumber+AXTool.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/1/3.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "NSNumber+AXTool.h"

@implementation NSNumber (AXTool)

/**
 将数字 整数部分转为每隔3位整数由","分隔,小数部分不变的字符串

 @return string
 */
- (NSString *)ax_numberToThousands{
    
    NSString *number = self.description;
    // 分隔符
    NSString *pide = @",";
    
    NSString *integer = @"";
    NSString *radixPoint = @"";
    BOOL contains = NO;
    if ([number containsString:@"."]) {
        contains = YES;
        // 若传入浮点数，则需要将小数点后的数字分离出来
        NSArray *comArray = [number componentsSeparatedByString:@"."];
        integer = [comArray firstObject];
        radixPoint = [comArray lastObject];
    } else {
        integer = number;
    }
    // 将整数按各个字符为一组拆分成数组
    NSMutableArray *integerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < integer.length; i ++) {
        NSString *subString = [integer substringWithRange:NSMakeRange(i, 1)];
        [integerArray addObject:subString];
    }
    // 将整数数组倒序每隔3个字符添加一个逗号“,”
    NSString *newNumber = @"";
    for (NSInteger i = 0 ; i < integerArray.count ; i ++) {
        NSString *getString = @"";
        NSInteger index = (integerArray.count-1) - i;
        if (integerArray.count > index) {
            getString = [integerArray objectAtIndex:index];
        }
        BOOL result = YES;
        if (index == 0 && integerArray.count%3 == 0) {
            result = NO;
        }
        if ((i+1)%3 == 0 && result) {
            newNumber = [NSString stringWithFormat:@"%@%@%@",pide,getString,newNumber];
        } else {
            newNumber = [NSString stringWithFormat:@"%@%@",getString,newNumber];
        }
    }
    if (contains) {
        newNumber = [NSString stringWithFormat:@"%@.%@",newNumber,radixPoint];
    }
    return newNumber;
}


/**
 解决 精度失真
这个方法会舍弃多余的0
 @return string
 */
- (NSString *)ax_description {
    
    NSString *doubleString = [NSString stringWithFormat:@"%lf", [self doubleValue]];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    NSString *resultStr = decNumber.stringValue;
    return resultStr;
}

@end
