//
//  UIImageView+AXCircle.m
//  BigApple
//
//  Created by liuweixing on 2017/9/20.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "UIImageView+AXCircle.h"
#import "UIImage+AXTool.h"
#import "UIImageView+WebCache.h"
@implementation UIImageView (AXCircle)

/**
 url路径 设置 image 圆形图片
 
 @param url url
 @param placeholderImage 占位图片
 */
- (void)ax_setImageCircleWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholderImage {
    
    CGFloat radius = MIN(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    placeholderImage=[placeholderImage ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
    
    [self sd_setImageWithURL:url placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        image = [image ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
        self.image = image;
        
    }];
    
}

@end
