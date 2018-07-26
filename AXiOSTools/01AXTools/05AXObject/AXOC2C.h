//
//  AXOC2C.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AXOC2C : NSObject

#pragma mark - System Settings

/**
 xcode 奔溃日志
 */
void ax_LogXcodeCache(void);

/**
 是debug 环境下
 
 @return 是否
 */
BOOL ax_isDebug(void);

/**
 * AppStore链接,填写自己的iD
 */
NSString * ax_AppStoreURL(NSString *appId);

/**
 AppStore 评分 url
 
 @param AppStoreID AppStoreID
 @return url String
 */
NSString * ax_AppStoreScoreURL(NSString *AppStoreID);

/**
 拨打电话,直接拨打
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTel(NSString *phone);

/**
 * 打开通用设置
 */
BOOL ax_OpenPrefsRoot(void);

#pragma mark - Foundation
/**
 是否能打开url
 
 @param str url str
 
 @return 是否打开
 */
BOOL ax_CanOpenURL(NSString *str);

/**
 打开url
 
 @param str url str
 
 @return 打开是否成功
 */
BOOL ax_OpenURL(NSString *str);

/**
 拨打电话,弹出alert界面
 
 @param phone 号码
 
 @return 是否成功
 */
BOOL ax_CallTelprompt(NSString *phone);

/**
 * URL With str
 */
NSURL *ax_URLStr(NSString *str);

/**
 * int --> NSString
 */
NSString *ax_intToString(int aInt);

/**
 * double --> NSString
 */
NSString *ax_doubleToString(double aDouble);

/**
 * double --> NSString
 */
NSString *ax_floatToString(float aFloat);

/**
 * 获取一个随机整数，范围在包括0，不包括自身
 */
int ax_getRandomZeroToValue(int to);

/**
 * 获取一个随机整数，范围在[from,t]，包括from，包括to
 */
int ax_getRandomFromTo(int from ,int to);


#pragma mark - UIKit

/**
 创建xib With xib 名称
 
 @param name xib 名称
 @return UINib
 */
UINib * ax_Nib(NSString *name);

/**
 UIImage With 图片名
 
 @param name 图片名
 @return UIImage
 */
UIImage * ax_Image(NSString *name);


@end
