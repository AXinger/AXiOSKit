//
//  AXNetManager+Tool.h
//  BigApple
//
//  Created by liuweixing on 2016/11/1.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXNetManager.h"

@interface AXNetManager (Version)
/**
 * 请求AppStore,得到app的版本信息
 */
+(void )appStoreVersionAppid:(NSString *)appid success:(void(^)(NSString *appVersion))successBlock failure:(void(^)(void))failureBlock;

/**
 * 工程版本号与AppStore版本号对比 0>相同 1,2,3>顺序的版本不同,失败,表示网络请求错误
 */

//+(void)versionToServerVersionByAppid:(NSString *)appid success:(void(^)(NSInteger comp))block failure:(void(^)(void))failureBlock;

/**
 * 工程版本号与AppStore版本号对比 
 -1  工程版本 < 服务器版本(不应该出现,说明用户未更新最新版本)
 0   工程版本 == 服务器版本
 1   工程版本 > 服务器版本
 */
+(void)projectVersionCompareAppStoreVersionWithAppid:(NSString *)appid success:(void(^)(NSInteger comp))successBlock failure:(void(^)(void))failureBlock;


@end
