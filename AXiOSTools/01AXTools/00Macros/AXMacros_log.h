//
//  AXMacros_log.h
//  BigApple
//
//  Created by liuweixing on 2017/6/28.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#ifndef AXMacros_log_h
#define AXMacros_log_h

//xcode8 log
#import "NSString+AXTool.h"

#ifdef DEBUG
#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]
#define AXLog(...) printf("%s [%s 第%d行]: %s\n\n",[[NSDate ax_nowDateToStringFormatter:@"yyyy-MM-dd HH:mm:ss.SSS"]UTF8String], FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define AXLog(...)
#endif


#ifdef DEBUG
#define FILEString [[NSString stringWithFormat:@"%s", __FILE__].lastPathComponent UTF8String]
#define NSLog(...) printf("%s [%s 第%d行]: %s\n\n",[[NSDate ax_nowDateToStringFormatter:@"yyyy-MM-dd HH:mm:ss.SSS"]UTF8String], FILEString  ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define NSLog(...)
#endif


#ifdef DEBUG
#define AXLog2(...) printf("%s\n\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define AXLog2(...)
#endif

#define  AXLogFunc AXLog(@"%s",__func__);

#define axLong_dealloc AXLog(@"dealloc %@",self.class)


#endif /* AXMacros_log_h */
