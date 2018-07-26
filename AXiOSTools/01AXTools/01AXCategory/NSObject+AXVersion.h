//
//  NSObject+AXVersion.h
//  AXTools
//
//  Created by liuweixing on 16/4/6.
//  Copyright © 2016年 liuweixing All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AXVersion)

/**
 请求AppStore,得到app的版本信息
 
 @param appid appid description
 @param block 得到app的版本信息
 */
- (void )ax_requestAppStoreVersionAppid:(NSString *)appid success:(void(^)(NSString *appVersion))block;

/**
 工程版本号与AppStore版本号对比 不常用
 
 @param appid appid
 @param block 0>相同 1,2,3>顺序的版本不同
 */
- (void)ax_versionToServerVersionByAppid:(NSString *)appid success:(void(^)(NSInteger comp))block;

/**
 当前版本号,与本地保存的版本号是否一致 用来显示 引导页 要主动保存版本号
 
 @param different 不一样回调
 @param same 一样回调
 */
- (void)ax_versionDifferent:(void(^)(NSString *thisVersion, NSString *lastVersion))different same:(void(^)(NSString *thisVersion, NSString *lastVersion))same;

/**
 主动 保存版本号
 
 @param thisVersion 版本号
 */
- (void)ax_setSaveAppVersion:(NSString *)thisVersion;

/**
 工程版本号 与App Store中版本号比较 用来升级
 
 @param appid appid
 @param resultBlock 回调
 */
- (void)ax_versionProjectCompareAppStoreWithAppid:(NSString *)appid comparisonResult:(void(^)(NSString *projectVersion, NSString *appStoreVersion, NSComparisonResult comparisonResult))resultBlock;

@end
