//
//  UIView+AXIBInspectable.h
//  AXiOSToolsDemo
//
//  Created by liuweixing on 2018/5/31.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AXIBInspectable)

/**
 *  设置圆角
 *  UIView masksToBounds 不设置,方便显示子视图
 */
@property (nonatomic, assign) IBInspectable CGFloat axCornRadius;

/**
 *  可视化设置边框宽度 borderWidth
 */
@property (nonatomic, assign) IBInspectable CGFloat axBordWidth;

/**
 *  可视化设置边框颜色 borderColor
 */
@property (nonatomic, strong) IBInspectable UIColor *axBordColor;


@end
