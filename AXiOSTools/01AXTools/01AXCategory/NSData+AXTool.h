//
//  NSData+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 16/8/10.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AXTool)

/**
 * NSData 进行 Base64
 */
- (NSString *)ax_toBase64;
/**
 *  NSData json解析
 */
- (id)ax_formJSON;

/**
 * 二进制转化为十六进制
 */
- (NSString *)ax_dataToHexString;

/**
 * NSData 转化 NSString
 */
- (NSString *)ax_toString;

@end
