//
//  NSObject+AXCacheImage.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/5/10.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "NSObject+AXCacheImage.h"
#import <SDWebImageManager.h>
@implementation NSObject (AXCacheImage)

/**
 SDWebImage 缓存url中的图片,

 @param url url
 @param completed 回调
 */
- (void)ax_cacheImage:(NSString *)url completed:(void(^)(BOOL isInCache))completed{
    
    [[SDWebImageManager sharedManager] cachedImageExistsForURL:[NSURL URLWithString:url] completion:^(BOOL isInCache) {
        if (completed){
            completed(isInCache);
        }
    }];
}

@end
