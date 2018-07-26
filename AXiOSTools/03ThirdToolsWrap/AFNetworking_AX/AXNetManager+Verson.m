//
//  AXNetManager+Tool.m
//  BigApple
//
//  Created by liuweixing on 2016/11/1.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXNetManager+Version.h"
#import "AXNetManager+Base.h"
#import "NSString+AXTool.h"

@implementation AXNetManager (Version)
+(void )appStoreVersionAppid:(NSString *)appid success:(void(^)(NSString *appVersion))successBlock failure:(void(^)(void))failureBlock{
    
    NSString *url = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/lookup?id=%@",appid];
    
    [AXNetManager POSTWithUrl:url showHUD:NO parameters:nil success:^(id json) {
        
        if (successBlock) {
            
            if ([json[@"resultCount"] boolValue]) {
                successBlock(json[@"results"][0][@"version"]);
            }else{
                NSString *loc = [NSString ax_getAppVersion];
                successBlock(loc);
            }
        }
        
        
    } failure:^(NSString *errorString) {
        if (failureBlock) {
            failureBlock();
        }
    }];
}

/**
 * 工程版本号与AppStore版本号对比
 -1  工程版本 < 服务器版本(不应该出现,说明用户未更新最新版本)
 0   工程版本 == 服务器版本
 1   工程版本 > 服务器版本
 */
+(void)projectVersionCompareAppStoreVersionWithAppid:(NSString *)appid success:(void(^)(NSInteger comp))successBlock failure:(void(^)(void))failureBlock{
    
    [self appStoreVersionAppid:appid success:^(NSString *appVersion) {
        
        if (successBlock == nil) {
            return ;
        }
        
        
        NSString *loc = [NSString ax_getAppVersion];
        NSString *ser = appVersion;
        AXLog(@"工程版本:loc--> %@   苹果服务器版本-->%@",loc,ser);
        successBlock([loc compare:ser options:NSNumericSearch]);
    
    } failure:^{
        if (failureBlock) {
            failureBlock();
        }
    }];
}


+(void)versionToMyServerVersionByAppid:(NSString *)appid success:(void(^)(BOOL comp))block failure:(void(^)(void))failureBlock{
    
    [self appStoreVersionAppid:appid success:^(NSString *appVersion) {
        NSString *loc = [NSString ax_getAppVersion];
        NSString *ser = appVersion;
        
        if ([loc isEqualToString:ser]) {
            block(0);
            return ;
        }
        
        
    } failure:^{
        if (failureBlock) {
            failureBlock();
        }
    }];
}



@end
