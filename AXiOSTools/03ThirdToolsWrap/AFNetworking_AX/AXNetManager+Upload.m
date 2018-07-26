//
//  AXNetManager+Upload.m
//  BigApple
//
//  Created by liuweixing on 2017/6/9.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "AXNetManager+Upload.h"
#import "MBProgressHUD+AX.h"
#import "AXMacros.h"

#pragma mark - NetFormData
@implementation  AXFormData

+ (instancetype)formDataWithData:(NSData *)data name:(NSString *)name filename:(NSString *)filename mimeType:(NSString *)mimeType{
    AXFormData *file =[[self alloc]init];
    file.data = data;
    file.name = name;
    file.filename = filename;
    file.mimeType = mimeType;
    return file;
}

@end

@implementation AXNetManager (Upload)

#pragma mark - 上传多个文件

/**
 上传多个文件
 
 @param url           url
 @param params        参数
 @param formDataArray 文件参数
 @param success       成功回调
 @param progress      进度回调
 @param failure       失败回调
 */
+ (void)POSTUpLoadWithURL:(NSString *)url showHud:(BOOL )showHud parameters:(NSDictionary *)parameters formDataArray:(NSArray<AXFormData *> *)formDataArray progress:(void (^)(NSProgress *aProgress))progress success:(void (^)(id json))success failure:(void (^)(NSString *errorString))failure{
   
     AXLog(@"%@ -- %@",url,parameters);
    MBProgressHUD *hud = nil;
    if (showHud) {
//        hud = [MBProgressHUD ax_showMessage:AXNetLoadTitle];
    }
    
    [[self shareManager] POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  formData) {
        
        if (showHud) {
            [hud hideAnimated:YES];
        }
        
        for (AXFormData *file in formDataArray) {
            
            [formData appendPartWithFileData:file.data name:file.name fileName:file.filename mimeType:file.mimeType];
        }
        
    } progress:^(NSProgress * uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        
        if (success) {
            success([self handleResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        
        if (hud) {
            [hud hideAnimated:YES];
            [MBProgressHUD ax_showError:error.localizedDescription];
        }
        
        if (failure) {
            failure(error.localizedDescription);
        }
    }];
}


#pragma mark - 上传单个Jpeg图片
/**
 * 上传单个Jpeg图片
 */
+ (void)uploadJpegWithURL:(NSString *)url showHud:(BOOL )showHud parameters:(NSDictionary *)parameters image:(UIImage* )image success:(void(^)(id json))success failure:(void(^)(NSString *errorString))failure{
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    
    NSString *name = [NSString ax_uuid];
    NSString *fileName =[NSString stringWithFormat:@"%@.jpeg",name];
    
    AXFormData *formData = [AXFormData formDataWithData:imageData name:name filename:fileName mimeType:jpegMimeType];
    
    [self POSTUpLoadWithURL:url showHud:showHud parameters:parameters formDataArray:@[formData] progress:nil success:success failure:failure];
}
@end
