//
//  AXNetManager.m
//  Xile
//
//  Created by liuweixing on 2016/10/19.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXNetManager.h"
#import "AXMacros.h"

NSString *const AXNetLoadTitle = @"Loading...";
NSString *const AXNetFailureText = @"网络连接错误";

NSString *const NetWorkStatusNotification = @"NetWorkStatusNotification";
NSString *const NetWorkStatusUnknownKey = @"NetWorkStatusUnknownKey";
NSString *const NetWorkStatusNotReachableKey = @"NetWorkStatusNotReachableKey";
NSString *const NetWorkStatusWANKey = @"NetWorkStatusWANKey";
NSString *const NetWorkStatusWiFiKey = @"NetWorkStatusWiFiKey";

/**
 * 上传图片 type
 */
NSString *const jpegMimeType = @"image/jpeg";
NSString *const gifMimeType = @"image/gif";
NSString *const pngMimeType = @"image/png";
NSString *const icoMimeType = @"image/png";
NSString *const imagMimeType = @"IMAGE/PNG/JPEG/GIF/WebP";


@implementation AXNetManager


//static NSURLSessionDataTask *_dataTask;

/**
 创建请求对象
 
 @return 请求对象
 */
+(AFHTTPSessionManager *)shareManager{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    
    //    //https请求使用
    //    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    //    NSData * certData =[NSData dataWithContentsOfFile:cerPath];
    //    NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
    //    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //    // 是否允许,NO-- 不允许无效的证书
    //    [securityPolicy setAllowInvalidCertificates:YES];
    //    // 设置证书
    //    [securityPolicy setPinnedCertificates:certSet];
    //    manager.securityPolicy = securityPolicy;
    return manager;
    
}

/**
 *  取消当前请求
 */
+ (void)cancelAFN{
    if (_dataTask) {
        [_dataTask cancel];
        _dataTask = nil;
    }
}


/**
 处理AFN 返回结果,进行判断 json xml等类型
 
 @param responseObject 数据
 @return 结果
 */
+(id)handleResponse:(id)responseObject{
    
    id json = nil;
    NSString *responseStr = [[responseObject class]description];
    
    if ([responseStr isEqualToString:@"_NSInlineData"]) {
        
        json  = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
    }else{
        json = responseObject;
    }
    return json;
}

/**
 监听网络转态
 */
+(void)setupNetWorkStatus:(void(^)(AFNetworkReachabilityStatus status))block{
    
    if (block) {
        //1获取网络监控管理者
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager startMonitoring];
        
        //2.设置网络状态发生变化时的代码
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            block(status);
            [axNotificationCenter postNotificationName:NetWorkStatusNotification object:nil userInfo:@{@"status":@(status)}];
            
        }];
    }
    
}

@end
