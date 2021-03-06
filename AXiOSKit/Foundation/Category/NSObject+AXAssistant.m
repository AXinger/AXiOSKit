//
//  NSObject+AXAssistant.m
//  AXiOSKit
//
//  Created by axing on 2019/7/26.
//  Copyright © 2019 liu.weixing. All rights reserved.
//

#import "NSObject+AXAssistant.h"
#import "AXMacros_log.h"
#import "NSBundle+AXBundle.h"
#include <libkern/OSAtomic.h>
#include <stdatomic.h>
#import <UIKit/UIKit.h>

/**
 是否能打开url
 
 @param url NSString || NSURL
 
 @return 是否打开
 */
BOOL ax_CanOpenURL(id url) {
    NSURL *URL = nil;
    
    if ([url isKindOfClass:NSString.class]) {
        URL = [NSURL URLWithString:url];
        
    } else if ([url isKindOfClass:URL.class]) {
        URL = (NSURL *)url;
    } else {
        return NO;
    }
    
    return [[UIApplication sharedApplication] canOpenURL:URL];
}

/**
 * 打开URL
 */
BOOL ax_OpenURLStr(id url) {
    NSURL *URL = nil;
    
    if ([url isKindOfClass:NSString.class]) {
        URL = [NSURL URLWithString:url];
        
    } else if ([url isKindOfClass:URL.class]) {
        URL = (NSURL *)url;
    } else {
        return NO;
    }
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL
                                           options:@{}
                                 completionHandler:nil];
        return YES;
        
    } else {
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 打开URL NSString || NSURL
 
 @param url NSString || NSURL
 @return BOOL
 */
BOOL ax_OpenURL(id url) {
    NSURL *URL = nil;
    
    if ([url isKindOfClass:NSString.class]) {
        URL = [NSURL URLWithString:url];
        
    } else if ([url isKindOfClass:NSURL.class]) {
        URL = (NSURL *)url;
    } else {
        return NO;
    }
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL
                                           options:@{}
                                 completionHandler:nil];
        return YES;
        
    } else {
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 拨打电话,弹出alert界面
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTelprompt(NSString *phone) {
    NSURL *URL = [NSURL
                  URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone]];
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL
                                           options:@{}
                                 completionHandler:nil];
        return YES;
        
    } else {
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 拨打电话,直接拨打
 拨打完电话回不到原来的应用，会停留在通讯录里，而且是直接拨打，不弹出提示
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTel(NSString *phone) {
    NSURL *URL =
    [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phone]];
    
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL
                                           options:@{}
                                 completionHandler:nil];
        return YES;
        
    } else {
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 * AppStore链接,填写自己的iD
 */
NSString *ax_AppStoreURL(NSString *appId) {
    return [NSString
            stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8", appId];
}

/**
 AppStore 评分 url
 
 @param AppStoreID AppStoreID
 @return url String
 */
NSString *ax_AppStoreScoreURL(NSString *AppStoreID) {
    return [NSString
            stringWithFormat:
            @"itms-apps://itunes.apple.com/app/id%@?action=write-review",
            AppStoreID];
}

/**
 * int --> NSString
 */
NSString *ax_intToString(int aInt) {
    return [NSString stringWithFormat:@"%d", aInt];
}

/**
 * double --> NSString
 */
NSString *ax_doubleToString(double aDouble) {
    return [NSString stringWithFormat:@"%lf", aDouble];
}

/**
 * double --> NSString
 */
NSString *ax_floatToString(float aFloat) {
    return [NSString stringWithFormat:@"%f", aFloat];
}

/**
 * 获取一个随机整数，范围在包括0，不包括自身
 */
int ax_randomZeroToValue(int to) { return arc4random() % to; }

/**
 * 获取一个随机整数，范围在[from,to），包括from，包括to
 */
int ax_randomFromTo(int from, int to) {
    return (int)(from + (arc4random() % (to - from + 1)));
}

/**
 * 打开通用设置
 */
BOOL ax_OpenPrefsRoot() {
    //    NSURL *URL = [NSURL URLWithString:@"prefs:root=General"];
    //过期
    NSURL *URL = nil;
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:URL
                                           options:@{}
                                 completionHandler:nil];
        return YES;
        
    } else {
        return [[UIApplication sharedApplication] openURL:URL];
    }
}

/**
 * str to URL
 */
NSURL *ax_URLWithStr(NSString *str) { return [NSURL URLWithString:str]; }

/**
 是debug 环境下
 
 @return 是否
 */
BOOL ax_isDebug() {
#ifdef DEBUG
    return YES;
#else
    return NO;
#endif
}

/**
 是否 iPad
 @return 是否
 */
BOOL ax_isiPad(void) {
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - UIKit

/**
 创建xib
 
 @param name xib 名称
 @return UINib
 */
UINib *ax_Nib(NSString *name) { return [UINib nibWithNibName:name bundle:nil]; }

/**
 创建xib
 
 @param aClass 必须 xib 同名称
 @return UINib
 */
UINib *ax_NibClass(Class aClass) {
    NSString *name = NSStringFromClass(aClass);
    return  [UINib nibWithNibName:name bundle:[NSBundle bundleForClass:aClass]];
    
}

/**
 UIImage
 
 @param name 图片名
 @return UIImage
 */
UIImage *ax_Image(NSString *name) {
    return [UIImage imageNamed:name];
}

/**
 gcd 创建串行队列 queue
 
 @param label 队列标识
 @return dispatch_queue_t
 */
dispatch_queue_t ax_get_queue_SERIAL(const char *label) {
    return dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
}

/**
 gcd 创建并行队列 queue
 
 @param label 队列标识
 @return dispatch_queue_t
 */
dispatch_queue_t ax_get_queue_CONCURRENT(const char *label) {
    return dispatch_queue_create(label, DISPATCH_QUEUE_CONCURRENT);
}

/**
 * Localizable.strings  标准名称 国际化文件
 */
NSString *AXNSLocalizedString(NSString *key) {
    return NSLocalizedString(key, nil);
}

/**
 * AXKit 自定义国际化文件
 */
NSString *AXKitLocalizedString(NSString *key) {
    NSString *str =
    [NSBundle.ax_mainBundle localizedStringForKey:key
                                            value:@""
                                            table:@"AXKitLocalizedString"];
    if (str.length == 0) {
        str = NSLocalizedStringFromTable(key, @"AXKitLocalizedString", @"");
    }
    return str;
}



const char *__dateChar() {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.SSSSSSZ";
    const char *dateChar =
    [dateFormatter stringFromDate:[NSDate date]].UTF8String;
    return dateChar;
}

/**
 封装NSLog用printf 没有__FILE__ 和 __FILE__
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
void AXLoger(NSString *format, ...) {
    
    __block va_list arg_list;
    va_start (arg_list, format);
    const char *dateChar = __dateChar();
    const char *formatChar = [[NSString alloc] initWithFormat:format
                                                    arguments:arg_list].UTF8String;
    printf("%s %s\n",dateChar,formatChar);
    va_end(arg_list);
}

/**
 封装NSLog用printf 有__FILE__ 和 __FILE__
 
 @param file __FILE__
 @param function __FUNCTION__
 @param line __LINE__
 @param format format
 @param ... NSLog样式 ...
 */
void AXLogerInfo(const char *file, const char *function, NSUInteger line,
                 NSString *format, ...) {
    __block va_list arg_list;
    va_start(arg_list, format);
    
    const char *dateChar = __dateChar();
    
    const char *formatChar =
    [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
    
    file = [NSString stringWithFormat:@"%s", file].lastPathComponent.UTF8String;
    
    printf("\n%s [%s 第%lu行]: %s\n%s\n", dateChar, file, (unsigned long)line,
           function, formatChar);
    va_end(arg_list);
}

void AXLogerMessage(NSString *msg, NSString *format, ...) {
    __block va_list arg_list;
    va_start(arg_list, format);
    const char *dateChar = __dateChar();
    const char *msgChar = msg.UTF8String;
    const char *formatChar =
    [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
    printf("\n%s [%s] %s", dateChar, msgChar, formatChar);
    va_end(arg_list);
}

/**
 封装NSLog用printf 纯输出
 
 @param format NSLog样式 format
 @param ... NSLog样式 ...
 */
void AXNoMsgLog(NSString *format, ...) {
    __block va_list arg_list;
    va_start(arg_list, format);
    // log内容
    const char *formatChar =
    [[NSString alloc] initWithFormat:format arguments:arg_list].UTF8String;
    printf("%s\n", formatChar);
    va_end(arg_list);
}

/**
 打开iPhone设置界面
 */
void AXOpenSettings() {
    ax_OpenURLStr(UIApplicationOpenSettingsURLString);
}
