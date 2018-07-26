//
//  NSData+AXTool.m
//  AXiOSTools
//
//  Created by liuweixing on 16/8/10.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import "NSData+AXTool.h"

@implementation NSData (AXTool)
/**
 * NSData 进行 Base64
 */
- (NSString *)ax_toBase64{
    return  [self base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

/**
 *  NSData json解析
 */
- (id)ax_formJSON{
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
}



//二进制转化为十六进制
- (NSString *)ax_dataToHexString{
    NSData *data = self;
    if (data == nil) {
        return nil;
    }
    
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        [hexString appendFormat:@"%02x", *p++];
    }
    
    return [hexString uppercaseString];
}

/**
 * NSData 转化 NSString
 */
- (NSString *)ax_toString{
    
    return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
