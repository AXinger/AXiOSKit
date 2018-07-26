//
//  NSURL+AXTool.h
//  AXiOSTools
//
//  Created by liuweixing on 16/6/17.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (AXTool)
/**
 * 电话号码拼接成URL
 */
+(NSURL *)ax_URLByPhone:(NSString *)phone;

@end
