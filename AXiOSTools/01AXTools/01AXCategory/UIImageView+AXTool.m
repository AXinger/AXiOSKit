//
//  UIImageView+AXTool.m
//  
//
//  Created by liuweixing on 15/10/28.
//  Copyright © 2015年 liuweixing. All rights reserved.
//

#import "UIImageView+AXTool.h"

@implementation UIImageView (AXTool)

- (void)ax_rotateWithOneCircleDuration:(NSTimeInterval)duration{
    //创建旋转对象
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //旋转角度
    rotationAnimation.toValue = @(M_PI * 2);
    //旋转一圈持续时间
    rotationAnimation.duration = duration;
    //旋转次数(最大float)
    rotationAnimation.repeatCount =FLT_MAX;
    //完成不移除对象
    rotationAnimation.removedOnCompletion = NO;
    //动画结束时,保持结束时状态
    rotationAnimation.fillMode = kCAFillModeForwards;
    //为事件绑定key
    [self.layer addAnimation:rotationAnimation forKey:@"rotate"];
}

//停止旋转,移除动画
- (void)ax_stopRotate{
    [self.layer removeAnimationForKey:@"rotate"];
}

- (void)ax_reverseRotateWithOneCircleDuration:(NSTimeInterval)duration{
    //创建旋转对象
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //旋转角度
    rotationAnimation.toValue = @(-M_PI * 2);
    //旋转一圈持续时间
    rotationAnimation.duration = duration;
    //旋转次数
    rotationAnimation.repeatCount =FLT_MAX;
    //完成不移除对象
    rotationAnimation.removedOnCompletion = NO;
    //动画结束时,保持结束时状态
    rotationAnimation.fillMode = kCAFillModeForwards;
    //为事件绑定key
    [self.layer addAnimation:rotationAnimation forKey:@"rotate"];
}

+ (instancetype)ax_imageWithFrame:(CGRect )frame imageName:(NSString *)image{
    UIImageView *imageView = [[self alloc]initWithFrame:frame];
    imageView.image=[UIImage imageNamed:image];
    return imageView;
}


/**
 画水印图片

 @param markImage 水印图片
 @param rect 位置
 */
- (void)ax_watermarkWith:(UIImage *)markImage inRect:(CGRect)rect{
    
   UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
 
    //原图
    [self.image drawInRect:self.bounds];
    //水印图
    [markImage drawInRect:rect];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.image = newPic;
}

@end
