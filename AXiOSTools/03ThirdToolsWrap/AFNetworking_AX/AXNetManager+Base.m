//
//  AXNetManager+Base.m
//  BigApple
//
//  Created by liuweixing on 2017/6/9.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "AXNetManager+Base.h"
#import "AXMacros.h"
#import "MBProgressHUD+AX.h"
@implementation AXNetManager (Base)
/**
 * post请求
 */
+ (void)POSTWithUrl:(NSString *)url parameters:(NSDictionary *)parameters success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{
    
    [self POSTWithUrl:url showHUD:NO parameters:parameters success:success failure:failure];
}
/**
 * post请求
 */
+ (void)POSTWithUrl:(NSString *)url showHUD:(BOOL )showHud parameters:(NSDictionary *)parameters  success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{
    
    AXLog(@"url:%@ -- parameters:%@",url,parameters);
    
    
    [self cancelAFN];
    
    MBProgressHUD *hud = nil;
    if (showHud) {
        hud = [MBProgressHUD ax_showMessage:AXNetLoadTitle];
    }
    
    _dataTask = [[self shareManager] POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        if (hud) {
            [hud hideAnimated:YES];
        }
        
        if (success) {
            success([self handleResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        AXLog(@"task.state>> %ld",(long)task.state);
        
        if (hud) {
            [hud hideAnimated:YES];
            [MBProgressHUD ax_showError:error.localizedDescription];
        }
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
    
    
}

/**
 get请求
 
 @param url url
 @param parameter 参数
 @param success 成功
 @param failure 失败
 @param log 是否打印参数,返回值
 */
+ (void)getURL:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(id json))success failure:(void(^)(NSInteger state))failure isLog:(BOOL )log{
    
    [self cancelAFN];
    
    if (log) {
        AXLog(@"%@ /n %@",url,parameter);
    }
    
    _dataTask = [[self shareManager] GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * task, id  responseObject) {
        if (success) {
            
            id obj = [self handleResponse:responseObject];
            
            if (log) {
                AXLog(@"success> %@",obj);
            }
            success(obj);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        if (failure) {
            if (log) {
                AXLog(@"failure> %ld /n %@",(long)task.state,error.localizedDescription);
            }
            failure(task.state);
        }
    }];
}


/**
 post请求
 
 @param url url
 @param parameter 参数
 @param success 成功
 @param failure 失败
 @param log 是否打印参数,返回值
 */
+ (void)postURL:(NSString *)url parameter:(NSDictionary *)parameter success:(void(^)(id json))success failure:(void(^)(NSInteger state))failure isLog:(BOOL )log{
    
    [self cancelAFN];
    
    if (log) {
        AXLog(@"%@ /n %@",url,parameter);
    }
    
    _dataTask = [[self shareManager] POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * task, id  responseObject) {
        if (success) {
            
            id json = [self handleResponse:responseObject];
            
            if (log) {
                AXLog(@"success json> %@",json);
            }
            success(json);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        if (failure) {
            if (log) {
                AXLog(@"failure> %ld /n %@",(long)task.state,error.localizedDescription);
            }
            failure(task.state);
        }
    }];
}



@end
