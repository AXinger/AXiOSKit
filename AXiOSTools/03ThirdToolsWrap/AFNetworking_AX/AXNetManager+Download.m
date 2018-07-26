//
//  AXNetManager+Download.m
//  BigApple
//
//  Created by liuweixing on 2016/11/22.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXNetManager+Download.h"
#import "AXNetManager.h"
#import "AXMacros.h"
@implementation AXNetManager (Download)

+ (void )postDownURL:(NSString *)url showStatus:(BOOL )showStatus downPath:(NSString *)downPath progress:(void (^)(float aProgress))progress success:(void(^)(NSString *filePath))success failure:(void(^)(NSInteger statusCode))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionDownloadTask *task = nil;
    axWeakObj(task);
    
    task = [manager downloadTaskWithRequest:request progress:^(NSProgress *downloadProgress) {
        
        if (progress) {
            progress(downloadProgress.fractionCompleted);
        }
        
    } destination:^NSURL * (NSURL *targetPath, NSURLResponse *response) {
        
        return [self getFileURL:downPath filename:response.suggestedFilename];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError * error) {
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
        
        if (httpResp.statusCode==200) {
            if (success) {
                success(filePath.path);
                [taskWeak cancel];
            }
        }else{
            if (failure) {
                failure(httpResp.statusCode);
            }
        }
    }];
    
    
//    //保持下载进度,,,我也不知道怎么实现的~~
//    if (progress) {
//        //设置下载进度回调方法：
//        [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
//            
//            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)downloadTask.response;
//            
//            if (httpResp.statusCode==200) {
//                
//                float pro = (CGFloat)totalBytesWritten/(CGFloat)totalBytesExpectedToWrite;
//                progress(pro);
//                AXLog(@"pro--> %lf", pro);
//            }else{
//                
//            }
//            
//        }];
//    }
    
    
    //判断网络,是否继续下载
    if (showStatus) {
        [self setupTask:task];
    }else{
        [task resume];
    }
    

}




/**
 * 拼接文件路径
 */
+(NSURL *)getFileURL:(NSString *)downPath filename:(NSString *)suggestedFilename{
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:downPath]){
        [[NSFileManager defaultManager]createDirectoryAtPath:downPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *path = [downPath stringByAppendingPathComponent:suggestedFilename];
    return [NSURL fileURLWithPath:path];
}

/**
 * 监听网络请求,开始下载任务
 */
+(void)setupTask:( NSURLSessionDownloadTask *)task{
    
    [self setupNetWorkStatus:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                [task cancel];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{ // 手机自带网络
                
                [axCurrentViewController ax_showNetDownloadGo:^{
                    [task resume];
                } cancel:^{
                    [task cancel];
                }];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{ // WIFI
                
                [task resume];
            }
                break;
                
            default:
                break;
        }

    }];
    
//    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
//    [reachabilityManager startMonitoring];
//    
//    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown: // 未知网络
//                break;
//                
//            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
//                [task cancel];
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN:{ // 手机自带网络
//                [axCurrentViewController ax_showNetDownloadGo:^{
//                    [task resume];
//                } cancel:^{
//                    [task cancel];
//                }];
//            }
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWiFi:{ // WIFI
//                
//                [task resume];
//            }
//                break;
//                
//            default:
//                break;
//        }
//        
//    }];

}


@end
