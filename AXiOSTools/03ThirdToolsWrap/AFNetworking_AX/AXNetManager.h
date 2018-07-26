//
//  AXNetManager.h
//  Xile
//
//  Created by liuweixing on 2016/10/19.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

FOUNDATION_EXPORT NSString *const AXNetLoadTitle;
FOUNDATION_EXPORT NSString *const AXNetFailureText;

FOUNDATION_EXPORT NSString *const NetWorkStatusNotification;
FOUNDATION_EXPORT NSString *const NetWorkStatusUnknownKey;
FOUNDATION_EXPORT NSString *const NetWorkStatusNotReachableKey;
FOUNDATION_EXPORT NSString *const NetWorkStatusWANKey;
FOUNDATION_EXPORT NSString *const NetWorkStatusWiFiKey;

/**
 * 上传文件 type
 */
FOUNDATION_EXPORT NSString *const jpegMimeType;
FOUNDATION_EXPORT NSString *const gifMimeType;
FOUNDATION_EXPORT NSString *const pngMimeType;
FOUNDATION_EXPORT NSString *const icoMimeType;
FOUNDATION_EXPORT NSString *const imagMimeType;

/**
 * 请求对象
 */
static NSURLSessionDataTask *_dataTask;

/**
 * 下载保存路径,iOS只有3个位置
 */
@interface AXNetManager : NSObject

/**
 创建请求对象

 @return 请求对象
 */
+(AFHTTPSessionManager *)shareManager;

/**
 处理AFN 返回结果,进行判断 json xml等类型
 
 @param responseObject 数据
 @return 结果
 */
+(id)handleResponse:(id)responseObject;

/**
 *  取消当前请求
 */
+ (void)cancelAFN;

/**
 监听网络转态
 */
+(void)setupNetWorkStatus:(void(^)(AFNetworkReachabilityStatus status))block;

@end

