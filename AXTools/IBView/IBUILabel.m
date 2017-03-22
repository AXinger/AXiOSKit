//
//  IBUILabel.m
//  AXTools
//
//  Created by Mole Developer on 16/8/1.
//  Copyright © 2016年 MoleDeveloper. All rights reserved.
//

#import "IBUILabel.h"

@implementation IBUILabel

/**
 *  设置边框宽度
 *
 *  @param borderWidth 可视化视图传入的值
 */
- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    if (borderWidth < 0) return;
    self.layer.borderWidth = borderWidth;
}

/**
 *  设置边框颜色
 *
 *  @param borderColor 可视化视图传入的值
 */
- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

/**
 *  设置圆角
 *
 *  @param cornerRadius 可视化视图传入的值
 */
- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0;
}

@end
