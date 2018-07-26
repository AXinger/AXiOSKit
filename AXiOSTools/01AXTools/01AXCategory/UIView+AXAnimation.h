//
//  UIView+Animation.h
//  动画
//
//  Created by liuweixing on 16/9/15.
//  Copyright © 2016年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AXAnimation)

/**
 * X轴旋转,顺时针方向
 */
- (void)rotateX;

/**
 * Y轴旋转,顺时针方向
 */
- (void)rotateY;

/**
 * Z轴旋转,顺时针方向
 */
- (void)rotateZ;

/**
 * 放大
 */

- (void)toBig;

/**
 * 缩小
 */

- (void)toSmall;

/**
 仿苹果图标 开始左右不停颤抖
 */
- (void)ax_startTrembleAnimate;

/**
 仿苹果图标 停止左右不停颤抖
 */
- (void)ax_stopTrembleAnimate;


/*============网上资料============*/
#pragma mark - 网上 资料

#pragma mark - Custom Animation

/**
 *    快速构建一个你自定义的动画,有以下参数供你设置.
 *
 *   @note  调用系统预置Type需要在调用类引入下句
 *
 *          #import <QuartzCore/QuartzCore.h>
 *
 *   @param type                动画过渡类型
 *   @param subType             动画过渡方向(子类型)
 *   @param duration            动画持续时间
 *   @param timingFunction      动画定时函数属性
 *
 *
 */

- (void)showAnimationType:(NSString *)type withSubType:(NSString *)subType  duration:(CFTimeInterval)duration timingFunction:(NSString *)timingFunction;

#pragma mark - Preset Animation

/**
 *  下面是一些常用的动画效果
 */

// reveal
- (void)animationRevealFromBottom;
- (void)animationRevealFromTop;
- (void)animationRevealFromLeft;
- (void)animationRevealFromRight;

// 渐隐渐消
- (void)animationEaseIn;
- (void)animationEaseOut;

// 翻转 Y轴
- (void)animationFlipFromLeft;
- (void)animationFlipFromRigh;

// 翻页
- (void)animationCurlUp;
- (void)animationCurlDown;

// push
- (void)animationPushUp;
- (void)animationPushDown;
- (void)animationPushLeft;
- (void)animationPushRight;

// move
- (void)animationMoveUp;
- (void)animationMoveDown;
- (void)animationMoveLeft;
- (void)animationMoveRight;

// 旋转缩放

// 各种旋转缩放效果
/**
 * 变形缩小
 */
- (void)animationRotateAndScaleEffects;

// 旋转同时缩小效果
- (void)animationRotateAndScaleDownUp;



#pragma mark - Private API

/**
 *  下面动画里用到的某些属性在当前API里是不合法的,但是也可以用.
 */

- (void)animationFlipFromTop;
- (void)animationFlipFromBottom;

- (void)animationCubeFromLeft;
- (void)animationCubeFromRight;
- (void)animationCubeFromTop;
- (void)animationCubeFromBottom;

- (void)animationSuckEffect;

- (void)animationRippleEffect;

- (void)animationCameraOpen;
- (void)animationCameraClose;


@end
