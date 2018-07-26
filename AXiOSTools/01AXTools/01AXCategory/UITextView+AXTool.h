//
//  UITextView+AXTool.h
//  AXiOSToolsDemo
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 liuweixing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (AXTool)

/**
 通过UILabel 设置站位文字
 
 @param aText 文字
 @param aColor 颜色
 */
- (void)ax_setPlaceholder:(NSString *)aText color:(UIColor *)aColor;

@end
