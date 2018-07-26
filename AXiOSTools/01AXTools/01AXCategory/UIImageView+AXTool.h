//
//  UIImageView+AXTool.h
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AXTool)

/**让当前视图顺时针不停旋转,duration为旋转一圈时间*/
- (void)ax_rotateWithOneCircleDuration:(NSTimeInterval)duration;

/**停止旋转*/
- (void)ax_stopRotate;

/**
 *  逆时针旋转
 */
- (void)ax_reverseRotateWithOneCircleDuration:(NSTimeInterval)duration;

/**
 UIImageView 初始化

 @param frame frame
 @param image image
 @return UIImageView
 */
+ (instancetype)ax_imageWithFrame:(CGRect )frame imageName:(NSString *)image;

/**
 画水印图片
 
 @param markImage 水印图片
 @param rect 位置
 */
- (void)ax_watermarkWith:(UIImage *)markImage inRect:(CGRect)rect;

@end
