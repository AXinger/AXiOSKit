//
//  UIButton+AXCircle.m
//  BigApple
//
//  Created by liuweixing on 2017/9/20.
//  Copyright © 2017年 liuweixing. All rights reserved.
//

#import "UIButton+AXCircle.h"
#import "UIButton+AXTool.h"
#import "UIImage+AXTool.h"
@implementation UIButton (AXCircle)

/**
 url路径 设置 BackgroundImage 圆形图片

 @param url url
 @param state 状态
 */
- (void)ax_setBackgroundImageCircleWithURL:(NSURL *)url forState:(UIControlState )state placeholderImage:(UIImage *)placeholderImage{
    
    CGFloat radius = MIN(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    placeholderImage=[placeholderImage ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
    
    [self sd_setBackgroundImageWithURL:url forState:state placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        image = [image ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
        [self setBackgroundImage:image forState:state];
    }];
    
}

/**
 url路径 设置 image 圆形图片
 
 @param url url
 @param state 状态
 */
- (void)ax_setImageCircleWithURL:(NSURL *)url forState:(UIControlState )state placeholderImage:(UIImage *)placeholderImage {
    
    CGFloat radius = MIN(self.frame.size.width*0.5, self.frame.size.height*0.5);
    
    placeholderImage=[placeholderImage ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
    
   [self sd_setImageWithURL:url forState:state placeholderImage:placeholderImage  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
       image = [image ax_imageCircleWithRadius:radius borderWidth:0 borderColor:nil];
       [self setBackgroundImage:image forState:UIControlStateNormal];
       
   }];
    
}

@end
