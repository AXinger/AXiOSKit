//
//  AppDelegateWebImage.m
//  AXiOSKit_Example
//
//  Created by 小星星吃KFC on 2020/11/14.
//  Copyright © 2020 axinger. All rights reserved.
//

#import "AppDelegateWebImage.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageWebPCoder/SDWebImageWebPCoder.h>

@implementation AppDelegateWebImage

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
    //    SDImageCache *imageCache=[SDImageCache.alloc initWithNamespace:@"image"];
    //    [imageCache queryCacheOperationForKey:@"ax.key" done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
    //
    //    }];
    //    [SDImageCache.sharedImageCache cachePathForKey:@"com.ax.cache.image.key1"];
    /// 缓存路径
    //    SDImageCache.defaultDiskCacheDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"com.ax.cache"];
    
    //    SDImageCache *ca = [SDImageCache.alloc initWithNamespace:@"webImage" diskCacheDirectory:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"com.ax.cache"]];
    //
    //    [SDImageCache.sharedImageCache clearWithCacheType:SDImageCacheTypeDisk completion:^{
    //
    //    }];
    /// 圆角
    //    id<SDImageTransformer> roundCornerTransformer =  [SDImageRoundCornerTransformer transformerWithRadius:5 corners:0 borderWidth:1 borderColor:UIColor.redColor];
    //
    //    SDWebImageManager.sharedManager.transformer = roundCornerTransformer;
    //
    //    SDWebImageManager.sharedManager.transformer =  [SDImagePipelineTransformer transformerWithTransformers:@[roundCornerTransformer]];
    
    
    /// Add a custom read-only cache path
    /// 附加高速缓存路径块
    //    [SDImageCache sharedImageCache].additionalCachePathBlock = ^NSString * _Nullable(NSString * _Nonnull key) {
    //        NSString *bundledPath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"CustomPathImages"];
    //        NSLog(@"bundledPath %@",bundledPath);
    //        NSString *fileName = [[SDImageCache sharedImageCache] cachePathForKey:key].lastPathComponent;
    //        return [bundledPath stringByAppendingPathComponent:fileName.stringByDeletingPathExtension];
    //    };
    //
    if (@available(iOS 14, tvOS 14, macOS 11, watchOS 7, *)) {
        // iOS 14 supports WebP built-in
        [SDImageCodersManager.sharedManager addCoder:SDImageAWebPCoder.sharedCoder];
    } else {
        // iOS 13 does not supports WebP, use third-party codec
        [SDImageCodersManager.sharedManager addCoder:SDImageWebPCoder.sharedCoder];
    }
    if (@available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *)) {
        // For HEIC animated image. Animated image is new introduced in iOS 13, but it contains performance issue for now.
        [SDImageCodersManager.sharedManager addCoder:SDImageHEICCoder.sharedCoder];
    }
    
    [SDImageCodersManager.sharedManager addCoder:SDImageAPNGCoder.sharedCoder];
    
    SDWebImageDownloaderRequestModifier *requestModifier = [SDWebImageDownloaderRequestModifier requestModifierWithBlock:^NSURLRequest * _Nullable(NSURLRequest * _Nonnull request) {
        if ([request.URL.host isEqualToString:@"foo"]) {
            NSMutableURLRequest *mutableRequest = [request mutableCopy];
            [mutableRequest setValue:@"foo=bar" forHTTPHeaderField:@"Cookie"];
            return [mutableRequest copy];
        }
        return request;
    }];
    SDWebImageDownloader.sharedDownloader.requestModifier = requestModifier;
    [self imageLoadingSettings];
    
    
    return YES;
}

- (void)imageLoadingSettings {
   [SDImageCache sharedImageCache].config.maxDiskSize = 3600 * 24 * 7;
   [SDImageCache sharedImageCache].config.maxMemoryCost = 1024 * 1024 * 20;
//   [SDImageCache sharedImageCache].config.shouldCacheImagesInMemory = NO;//是否缓存到内存中 默认是 YES
//   [SDImageCache sharedImageCache].config.shouldDecompressImages = NO;//是否解压图像 默认是 YES
//   [SDWebImageDownloader sharedDownloader].shouldDecompressImages = NO;
   [SDImageCache sharedImageCache].config.diskCacheReadingOptions = NSDataReadingMappedIfSafe;
    
}


@end
