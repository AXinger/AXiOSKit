//
//  UIButton+AXCircle.h
//  BigApple
//
//  Created by Mole Developer on 2017/9/20.
//  Copyright © 2017年 MoleDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
@interface UIButton (AXCircle)

/**
 url路径 设置 BackgroundImage 圆形图片
 
 @param url url
 @param state 状态
 */
-(void)ax_setBackgroundImageCircleWithURL:(NSURL *)url forState:(UIControlState )state placeholderImage:(UIImage *)placeholderImage;
/**
 url路径 设置 image 圆形图片
 
 @param url url
 @param state 状态
 */
-(void)ax_setImageCircleWithURL:(NSURL *)url forState:(UIControlState )state placeholderImage:(UIImage *)placeholderImage;

@end
