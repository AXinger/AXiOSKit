//
//  UIImageView+SDImageCut.m
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/4/10.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import "UIImageView+SDImageCut.h"
#import <objc/runtime.h>
#import "UIImageView+WebCache.h"
#import "UIView+WebCacheOperation.h"
#import "UIView+WebCache.h"
#import "SDWebImageCompat.h"
//NSString * const SDWebImageInternalSetImageGroupKey1 = @"internalSetImageGroup";
//NSString * const SDWebImageExternalCustomManagerKey1 = @"externalCustomManager";
static char imageURLKey;
@implementation UIImageView (SDImageCut)

//剪裁方法
- (UIImage *)imageWithRoundCorner:(UIImage *)sourceImage cornerRadius:(CGFloat)cornerRadius size:(CGSize)size{ CGFloat scale = [UIScreen mainScreen].scale; UIGraphicsBeginImageContextWithOptions(size, NO, scale); CGRect bounds = CGRectMake(0, 0, size.width, size.height); UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius]; [path addClip]; [sourceImage drawInRect:bounds]; UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext(); return image;
    
}

//- (void)sd_RoundImageWithURL:(NSURL *)url cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock {
//
//    [self sd_setRoundImageWithURL:url cornerRadius:cornerRadius placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
//
//}


//添加在UIImageView+WebCache

//- (void)sd_setRoundImageWithURL:(NSURL *_Nullable)url cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage *_Nullable)placeholder  completed:(nullable SDExternalCompletionBlock)completedBlock {
//
//       __weak typeof(self)weakSelf = self;
//    [self sd_setRoundImageWithURL:url cornerRadius:cornerRadius placeholderImage:placeholder operationKey:nil setImageBlock:nil options:0 progress:nil completed:completedBlock context:nil];
//
//
//}

- (void)ax_setCutImageWithURL:(NSURL *_Nullable)url placeholderImage:(UIImage *_Nullable)placeholder  completed:(nullable SDExternalCompletionBlock)completedBlock{
    
    [self sd_setImageWithURL:url imagCut:^UIImage *(UIImage *doImage) {
        return [self imageWithRoundCorner:doImage cornerRadius:10 size:self.frame.size ];
    } placeholderImage:placeholder operationKey:nil setImageBlock:nil options:0 progress:nil completed:completedBlock context:nil];
    
}



//- (void)sd_setRoundImageWithURL:(NSURL *_Nullable)url cornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage *_Nullable)placeholder operationKey:(nullable NSString *)operationKey setImageBlock:(nullable SDSetImageBlock)setImageBlock options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock context:(nullable NSDictionary *)context {
//    
//    NSString *validOperationKey = operationKey ?: NSStringFromClass([self class]);
//    [self sd_cancelImageLoadOperationWithKey:validOperationKey];
//    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    
//    if (!(options & SDWebImageDelayPlaceholder)) {
//        if ([context valueForKey:SDWebImageInternalSetImageGroupKey]) {
//            dispatch_group_t group = [context valueForKey:SDWebImageInternalSetImageGroupKey];
//            dispatch_group_enter(group);
//        }
//        dispatch_main_async_safe(^{
//            [self sd_setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock];
//        });
//    }
//    
//    if (url) {
//        // check if activityView is enabled or not
//        if ([self sd_showActivityIndicatorView]) {
//            [self sd_addActivityIndicator];
//        }
//        
//        SDWebImageManager *manager;
//        if ([context valueForKey:SDWebImageExternalCustomManagerKey]) {
//            manager = (SDWebImageManager *)[context valueForKey:SDWebImageExternalCustomManagerKey];
//        } else {
//            manager = [SDWebImageManager sharedManager];
//        }
//        
//        __weak __typeof(self)wself = self;
//        id <SDWebImageOperation> operation = [manager loadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            __strong __typeof (wself) sself = wself;
//            [sself sd_removeActivityIndicator];
//            if (!sself) { return; }
//            BOOL shouldCallCompletedBlock = finished || (options & SDWebImageAvoidAutoSetImage);
//            BOOL shouldNotSetImage = ((image && (options & SDWebImageAvoidAutoSetImage)) ||
//                                      (!image && !(options & SDWebImageDelayPlaceholder)));
//            SDWebImageNoParamsBlock callCompletedBlockClojure = ^{
//                if (!sself) { return; }
//                if (!shouldNotSetImage) {
//                    [sself sd_setNeedsLayout];
//                }
//                if (completedBlock && shouldCallCompletedBlock) {
//                    completedBlock(image, error, cacheType, url);
//                }
//            };
//            
//            // case 1a: we got an image, but the SDWebImageAvoidAutoSetImage flag is set
//            // OR
//            // case 1b: we got no image and the SDWebImageDelayPlaceholder is not set
//            if (shouldNotSetImage) {
//                dispatch_main_async_safe(callCompletedBlockClojure);
//                return;
//            }
//            
//            UIImage *targetImage = nil;
//            NSData *targetData = nil;
//            if (image) {
//                // case 2a: we got an image and the SDWebImageAvoidAutoSetImage is not set
//                targetImage = image;
//                targetData = data;
//            } else if (options & SDWebImageDelayPlaceholder) {
//                // case 2b: we got no image and the SDWebImageDelayPlaceholder flag is set
//                targetImage = placeholder;
//                targetData = nil;
//            }
//            
//            if ([context valueForKey:SDWebImageInternalSetImageGroupKey]) {
//                dispatch_group_t group = [context valueForKey:SDWebImageInternalSetImageGroupKey];
//                dispatch_group_enter(group);
//                dispatch_main_async_safe(^{
//                    [sself sd_setImage:targetImage imageData:targetData basedOnClassOrViaCustomSetImageBlock:setImageBlock];
//                });
//                // ensure completion block is called after custom setImage process finish
//                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//                    callCompletedBlockClojure();
//                });
//            } else {
//                dispatch_main_async_safe(^{
//                    [sself sd_setImage:targetImage imageData:targetData basedOnClassOrViaCustomSetImageBlock:setImageBlock];
//                    callCompletedBlockClojure();
//                });
//            }
//        }];
//        [self sd_setImageLoadOperation:operation forKey:validOperationKey];
//    } else {
//        dispatch_main_async_safe(^{
//            [self sd_removeActivityIndicator];
//            if (completedBlock) {
//                NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
//                completedBlock(nil, error, SDImageCacheTypeNone, url);
//            }
//        });
//    }

    
    
//        [self sd_cancelCurrentImageLoad];
//
//        objc_setAssociatedObject(self, &imageURLKey1, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//
//        if (!(options & SDWebImageDelayPlaceholder)) {
//
//            dispatch_main_async_safe(^{
//                //剪切图片
//                self.image = [self imageWithRoundCorner:placeholder cornerRadius:cornerRadius size:self.frame.size]; });
//        }
//        if (url) {
//
//            if ([self sd_showActivityIndicatorView]) {
//                [self sd_addActivityIndicator];
//            }
//
//            __weak __typeof(self)wself = self;
//            id <SDWebImageOperation> operation = [[SDWebImageManager sharedManager] loadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//
//                [wself sd_removeActivityIndicator];
//                if (!wself) return;
//
//                dispatch_main_async_safe(^{
//                    if (!wself) return;
//                    if (image && (options & SDWebImageAvoidAutoSetImage) && completedBlock) {
//
//                        //剪切图片
//                        completedBlock( [self imageWithRoundCorner:image cornerRadius:cornerRadius size:self.frame.size], error, cacheType, url);
//                        return;
//
//                    } else if (image) {
//                        //剪切图片
//                        wself.image = [self imageWithRoundCorner:image cornerRadius:cornerRadius size:self.frame.size]; [wself setNeedsLayout];
//
//                    } else { if ((options & SDWebImageDelayPlaceholder)) {
//                        //剪切图片
//                        wself.image = [self imageWithRoundCorner:placeholder cornerRadius:cornerRadius size:self.frame.size]; [wself setNeedsLayout]; }
//
//                    } if (completedBlock && finished) { //这时候读的是缓存里的，无需再剪裁
//                        completedBlock(image, error, cacheType, url);
//                    }
//                });
//
//            }];
//            [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
//
//        } else {
//            dispatch_main_async_safe(^{
//
//                [self sd_removeActivityIndicator];
//
//                if (completedBlock) {
//                    NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
//                    completedBlock(nil, error, SDImageCacheTypeNone, url);
//
//                } });
//
//        }
    
    //   封装后的代码
//    [self ax_setImageWithURL:url imagCut:^UIImage *(UIImage *doImage) {
//
//        return [self imageWithRoundCorner:doImage cornerRadius:cornerRadius size:self.frame.size];
//
//    } placeholderImage:placeholder completed:completedBlock];
    
//}


//- (void)ax_setImageWithURL:(NSURL *)url imagCut:(UIImage*(^)(UIImage *doImage))imagCutBlock placeholderImage:(UIImage *)placeholder completed:(nullable SDExternalCompletionBlock)completedBlock{
//    
//    [self ax_setImageWithURL:url imagCut:imagCutBlock placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
//    
//}

//// sd_image 源码,
//- (void)ax_setImageWithURL:(NSURL *)url imagCut:(UIImage*(^)(UIImage *doImage))imagCutBlock placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock  {
//
//    [self sd_cancelCurrentImageLoad];
//
//    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//
//    if (!(options & SDWebImageDelayPlaceholder)) {
//
//        dispatch_main_async_safe(^{
//            //剪切图片
//            self.image = imagCutBlock(placeholder);
//        });
//
//    }
//    if (url) {
//
//        if ([self sd_showActivityIndicatorView]) {
//            [self sd_addActivityIndicator];
//
//        }
//
//        __weak __typeof(self)wself = self;
//        id <SDWebImageOperation> operation = [[SDWebImageManager sharedManager] loadImageWithURL:url options:0 progress:nil completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//
//            [wself sd_removeActivityIndicator];
//            if (!wself) return;
//
//            dispatch_main_async_safe(^{
//                if (!wself) return;
//                if (image && (options & SDWebImageAvoidAutoSetImage) && completedBlock) {
//
//                    //剪切图片
//                    completedBlock( imagCutBlock(image), error, cacheType, url);
//                    return;
//
//                } else if (image) {
//                    //剪切图片
//                    wself.image = imagCutBlock(image);
//                    [wself setNeedsLayout];
//
//                } else { if ((options & SDWebImageDelayPlaceholder)) {
//                    //剪切图片
//                    wself.image = imagCutBlock(placeholder);
//                    [wself setNeedsLayout]; }
//
//                } if (completedBlock && finished) { //这时候读的是缓存里的，无需再剪裁
//                    completedBlock(image, error, cacheType, url);
//                }
//            });
//
//        }];
//        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
//
//    } else {
//
//        dispatch_main_async_safe(^{
//
//            [self sd_removeActivityIndicator];
//
//            if (completedBlock) {
//                NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
//                completedBlock(nil, error, SDImageCacheTypeNone, url);
//
//            } });
//
//    }
//
//}


- (void)sd_setImageWithURL:(NSURL *_Nullable)url imagCut:(UIImage*(^)(UIImage *doImage))imagCutBlock placeholderImage:(UIImage *_Nullable)placeholder operationKey:(nullable NSString *)operationKey setImageBlock:(nullable SDSetImageBlock)setImageBlock options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(nullable SDExternalCompletionBlock)completedBlock context:(nullable NSDictionary *)context {
    
    NSString *validOperationKey = operationKey ?: NSStringFromClass([self class]);
    [self sd_cancelImageLoadOperationWithKey:validOperationKey];
    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (!(options & SDWebImageDelayPlaceholder)) {
        if ([context valueForKey:SDWebImageInternalSetImageGroupKey]) {
            dispatch_group_t group = [context valueForKey:SDWebImageInternalSetImageGroupKey];
            dispatch_group_enter(group);
        }
        dispatch_main_async_safe(^{
            //新代码--剪切图片
            [self sd_setImage:imagCutBlock(placeholder) imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock];

            //原代码
//            [self sd_setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock];

        });
    }

    if (url) {
        // check if activityView is enabled or not
        if ([self sd_showActivityIndicatorView]) {
            [self sd_addActivityIndicator];
        }

        SDWebImageManager *manager;
        if ([context valueForKey:SDWebImageExternalCustomManagerKey]) {
            manager = (SDWebImageManager *)[context valueForKey:SDWebImageExternalCustomManagerKey];
        } else {
            manager = [SDWebImageManager sharedManager];
        }

        __weak __typeof(self)wself = self;
        id <SDWebImageOperation> operation = [manager loadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            __strong __typeof (wself) sself = wself;
            [sself sd_removeActivityIndicator];
            if (!sself) { return; }
            BOOL shouldCallCompletedBlock = finished || (options & SDWebImageAvoidAutoSetImage);
            BOOL shouldNotSetImage = ((image && (options & SDWebImageAvoidAutoSetImage)) ||
                                      (!image && !(options & SDWebImageDelayPlaceholder)));
            SDWebImageNoParamsBlock callCompletedBlockClojure = ^{
                if (!sself) { return; }
                if (!shouldNotSetImage) {
                    [sself sd_setNeedsLayout];
                }
                if (completedBlock && shouldCallCompletedBlock) {

                    //新代码--剪切图片
                    completedBlock(imagCutBlock(image), error, cacheType, url);

                    //原代码
//                    completedBlock(image, error, cacheType, url);
                }
            };

            // case 1a: we got an image, but the SDWebImageAvoidAutoSetImage flag is set
            // OR
            // case 1b: we got no image and the SDWebImageDelayPlaceholder is not set
            if (shouldNotSetImage) {
                dispatch_main_async_safe(callCompletedBlockClojure);
                return;
            }

            UIImage *targetImage = nil;
            NSData *targetData = nil;
            if (image) {
                // case 2a: we got an image and the SDWebImageAvoidAutoSetImage is not set

                //新代码--剪切图片
                targetImage = imagCutBlock(image);
//                targetData = UIImagePNGRepresentation(targetImage);

               targetData =  UIImageJPEGRepresentation(targetImage,1);
                
                //原代码
//                targetImage = image;
//                targetData = data;
            } else if (options & SDWebImageDelayPlaceholder) {
                // case 2b: we got no image and the SDWebImageDelayPlaceholder flag is set

                 //新代码--剪切图片
                targetImage = imagCutBlock(placeholder);
                 //原代码
//                targetImage = placeholder;
                targetData = nil;
            }

            if ([context valueForKey:SDWebImageInternalSetImageGroupKey]) {
                dispatch_group_t group = [context valueForKey:SDWebImageInternalSetImageGroupKey];
                dispatch_group_enter(group);
                dispatch_main_async_safe(^{
                    [sself sd_setImage:targetImage imageData:targetData basedOnClassOrViaCustomSetImageBlock:setImageBlock];
                });
                // ensure completion block is called after custom setImage process finish
                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                    callCompletedBlockClojure();
                });
            } else {
                dispatch_main_async_safe(^{
                    [sself sd_setImage:targetImage imageData:targetData basedOnClassOrViaCustomSetImageBlock:setImageBlock];
                    callCompletedBlockClojure();
                });
            }
        }];
        [self sd_setImageLoadOperation:operation forKey:validOperationKey];
    } else {
        dispatch_main_async_safe(^{
            [self sd_removeActivityIndicator];
            if (completedBlock) {
                NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
    
//    NSString *validOperationKey = operationKey ?: NSStringFromClass([self class]);
//    [self sd_cancelImageLoadOperationWithKey:validOperationKey];
//    objc_setAssociatedObject(self, &imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//    if (!(options & SDWebImageDelayPlaceholder)) {
//        if ([context valueForKey:SDWebImageInternalSetImageGroupKey]) {
//            dispatch_group_t group = [context valueForKey:SDWebImageInternalSetImageGroupKey];
//            dispatch_group_enter(group);
//        }
//        dispatch_main_async_safe(^{
//            [self sd_setImage:placeholder imageData:nil basedOnClassOrViaCustomSetImageBlock:setImageBlock];
//        });
//    }
//
//    if (url) {
//        // check if activityView is enabled or not
//        if ([self sd_showActivityIndicatorView]) {
//            [self sd_addActivityIndicator];
//        }
//
//        SDWebImageManager *manager;
//        if ([context valueForKey:SDWebImageExternalCustomManagerKey]) {
//            manager = (SDWebImageManager *)[context valueForKey:SDWebImageExternalCustomManagerKey];
//        } else {
//            manager = [SDWebImageManager sharedManager];
//        }
//
//        __weak __typeof(self)wself = self;
//        id <SDWebImageOperation> operation = [manager loadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//            __strong __typeof (wself) sself = wself;
//            [sself sd_removeActivityIndicator];
//            if (!sself) { return; }
//            BOOL shouldCallCompletedBlock = finished || (options & SDWebImageAvoidAutoSetImage);
//            BOOL shouldNotSetImage = ((image && (options & SDWebImageAvoidAutoSetImage)) ||
//                                      (!image && !(options & SDWebImageDelayPlaceholder)));
//            SDWebImageNoParamsBlock callCompletedBlockClojure = ^{
//                if (!sself) { return; }
//                if (!shouldNotSetImage) {
//                    [sself sd_setNeedsLayout];
//                }
//                if (completedBlock && shouldCallCompletedBlock) {
//                    completedBlock(image, error, cacheType, url);
//                }
//            };
//
//            // case 1a: we got an image, but the SDWebImageAvoidAutoSetImage flag is set
//            // OR
//            // case 1b: we got no image and the SDWebImageDelayPlaceholder is not set
//            if (shouldNotSetImage) {
//                dispatch_main_async_safe(callCompletedBlockClojure);
//                return;
//            }
//
//            UIImage *targetImage = nil;
//            NSData *targetData = nil;
//            if (image) {
//                // case 2a: we got an image and the SDWebImageAvoidAutoSetImage is not set
//                targetImage = image;
//                targetData = data;
//            } else if (options & SDWebImageDelayPlaceholder) {
//                // case 2b: we got no image and the SDWebImageDelayPlaceholder flag is set
//                targetImage = placeholder;
//                targetData = nil;
//            }
//
//            if ([context valueForKey:SDWebImageInternalSetImageGroupKey]) {
//                dispatch_group_t group = [context valueForKey:SDWebImageInternalSetImageGroupKey];
//                dispatch_group_enter(group);
//                dispatch_main_async_safe(^{
//                    [sself sd_setImage:targetImage imageData:targetData basedOnClassOrViaCustomSetImageBlock:setImageBlock];
//                });
//                // ensure completion block is called after custom setImage process finish
//                dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//                    callCompletedBlockClojure();
//                });
//            } else {
//                dispatch_main_async_safe(^{
//                    [sself sd_setImage:targetImage imageData:targetData basedOnClassOrViaCustomSetImageBlock:setImageBlock];
//                    callCompletedBlockClojure();
//                });
//            }
//        }];
//        [self sd_setImageLoadOperation:operation forKey:validOperationKey];
//    } else {
//        dispatch_main_async_safe(^{
//            [self sd_removeActivityIndicator];
//            if (completedBlock) {
//                NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
//                completedBlock(nil, error, SDImageCacheTypeNone, url);
//            }
//        });
//    }
    
//    [self sd_internalSetImageWithURL:url
//                    placeholderImage:placeholder
//                             options:0
//                        operationKey:nil
//                       setImageBlock:nil
//                            progress:nil
//                           completed:completedBlock];
}

- (void)sd_setImage:(UIImage *)image imageData:(NSData *)imageData basedOnClassOrViaCustomSetImageBlock:(SDSetImageBlock)setImageBlock {
    if (setImageBlock) {
        setImageBlock(image, imageData);
        return;
    }
    
#if SD_UIKIT || SD_MAC
    if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self;
        imageView.image = image;
    }
#endif
    
#if SD_UIKIT
    if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        [button setImage:image forState:UIControlStateNormal];
    }
#endif
}

- (void)sd_setNeedsLayout {
#if SD_UIKIT
    [self setNeedsLayout];
#elif SD_MAC
    [self setNeedsLayout:YES];
#endif
}

@end
