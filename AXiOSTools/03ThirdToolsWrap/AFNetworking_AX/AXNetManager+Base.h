//
//  AXNetManager+Base.h
//  BigApple
//
//  Created by liuweixing on 2017/6/9.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "AXNetManager.h"

@interface AXNetManager (Base)

/**
 * post请求
 */
+ (void)POSTWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure;

/**
 * post请求,含有hud
 */
+ (void)POSTWithUrl:(NSString *)url showHUD:(BOOL )showHud parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure;

/**
 get请求
 
 @param url url
 @param parameter 参数
 @param success 成功
 @param failure 失败
 @param log 是否打印参数,返回值
 */
+ (void)getURL:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(id json))success failure:(void(^)(NSInteger state))failure isLog:(BOOL )log;

/**
 post请求
 
 @param url url
 @param parameter 参数
 @param success 成功
 @param failure 失败
 @param log 是否打印参数,返回值
 */
+ (void)postURL:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(id json))success failure:(void(^)(NSInteger state))failure isLog:(BOOL )log;

@end
