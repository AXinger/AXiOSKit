//
//  UIViewController+AXNavBarConfig.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/21.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 主要配合 RTRootNavigationController 为每个页面设置不同 NavigationBa
 */
@interface UIViewController (AXNavBarConfig)

/**
 设置 navigationBar 颜色 文字颜色
 
 @param aColor navigationBar 颜色
 @param textColor 文字颜色
 */
-(void)ax_setNavigationBarColor:(UIColor *)aColor textColor:(UIColor *)textColor;

/**
 设置 navigationBar 透明
 */
-(void)ax_setNavBarTransparent;

/**
 ScrollView navigationBar 滚动渐变
 
 @param aColor 颜色
 @param alpha 渐变值
 */
-(void)ax_setNavBarGradientWithColor:(UIColor *)aColor alpha:(CGFloat )alpha;

/**
 取消分隔线
 */
-(void)ax_setSeparatorHidden;

/**
 item title 文字白色,
 */
-(void)ax_setNavigationTextWhite;

/**
 navigationBar 文字颜色
 
 @param textColor 颜色
 */
-(void)ax_setNavigationBarTextColor:(UIColor *)textColor;

@end
