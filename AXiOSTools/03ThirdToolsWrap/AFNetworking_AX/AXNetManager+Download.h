//
//  AXNetManager+Download.h
//  BigApple
//
//  Created by liuweixing on 2016/11/22.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import "AXNetManager.h"
@interface AXNetManager (Download)

/**
 下载文件

 @param url url
 @param showStatus 是否控制流量时暂停下载
 @param downPath 保存地址
 @param progress 进度
 @param success 完成
 @param failure 失败 code != 200
 */
+ (void )postDownURL:(NSString *)url showStatus:(BOOL )showStatus downPath:(NSString *)downPath progress:(void (^)(float aProgress))progress success:(void(^)(NSString *filePath))success failure:(void(^)(NSInteger statusCode))failure;


@end
