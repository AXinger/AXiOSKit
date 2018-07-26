//
//  AXTouchIDManager.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/6/23.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 使用时,定义属性,不用单例 方便内存
 @property(nonatomic,strong)AXTouchIDManager *touchIDManager;
 */

@interface AXTouchIDManager : NSObject

/**
 是否支持touch id
 
 @return 是否
 */
+ (BOOL )supportTouchID;
/**
 是否支持touch id
 
 @return 是否
 */
- (BOOL )supportTouchID;

/**
 打开touch id
 
 @param success 成功
 @param inputPassword 失败后,点击输入密码
 @param cancel 点击取消
 */

/**
  打开touch id

 @param successBlock 成功
 @param failureBlock 3次失败,避免5次失败
 @param inputPasswordBlock 失败后,点击输入密码
 @param cancelBlock 点击取消
 */
- (void)openTouchIDWithSuccess:(void(^)(void))successBlock failure:(void(^)(void))failureBlock inputPassword:(void(^)(void))inputPasswordBlock cancel:(void(^)(void))cancelBlock;

@end
